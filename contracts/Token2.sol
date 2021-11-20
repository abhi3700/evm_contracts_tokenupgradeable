//SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import '@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol';
import "hardhat/console.sol";

contract Token2 is Initializable, OwnableUpgradeable, 
        ERC20Upgradeable, PausableUpgradeable, 
        ERC20BurnableUpgradeable, ReentrancyGuardUpgradeable {

    // ==========State variables====================================
    mapping(address => uint256) public vaultBalances;

    // ==========Events=============================================

    // ==========Constructor========================================
    /// @notice replacement of `constructor` for upgradeable contracts
    function initialize(string memory _name, string memory _symbol) public initializer {
        __Ownable_init();
        __ERC20_init(_name, _symbol);
        __ERC20Burnable_init();
    }

    // ==========Modifiers==========================================
    /// @dev Throws if called by any account other than the owner.
    ///      Also, added vault contract address into permission for minting.
    modifier onlyOwnerM() {
        require(owner() == _msgSender() || address(this) == _msgSender(), "Ownable: caller is not the owner or vault address");
        _;
    }

    // ==========Functions==========================================
    function receive() external payable {
        // update balance of depositor
        vaultBalances[_msgSender()] = msg.value;

        // mint equivalent amount of ERC20 tokens
        bool success = mint(_msgSender(), msg.value);               // parse in wei
        require(success, "Receive: Token Minting failed");
    }
    
    
    /// @notice Mints given amount of tokens to recipient
    /// @dev only owner can call this mint function
    /// @param recipient address of account to receive the tokens
    /// @param amount amount of tokens to mint
    /// @return true if the function succeeds
    function mint(address recipient, uint256 amount) 
        public 
        payable 
        whenNotPaused 
        onlyOwnerM 
        nonReentrant 
        returns (bool) 
    {
        require(amount != 0, "amount == 0");
        _mint(recipient, amount);

        return true;
    }


    /// @notice burn function
    /// @param from token holder address
    /// @param amount mint amount
    /// @return true if the function succeeds
    function burn(address from, uint256 amount) public whenNotPaused nonReentrant returns (bool) {
        _burn(from, amount);

        // calculate the transfer amount
        uint256 transferAmt = 0.9.mul(amount);

        // update the vault balance
        vaultBalances[_msgSender()] = vaultBalances[_msgSender()].sub(transferAmt);

        // transfer 90% of ETH (in wei) corresponding to repayment amount
        (bool sent, /*bytes memory data*/) = _msgSender().call{value: transferAmt}("");     // parse in wei
        require(sent, "Burn: ETH Token Transfer failed");

        return true;
    }

}