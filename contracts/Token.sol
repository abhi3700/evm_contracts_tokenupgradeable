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

contract Token is Initializable, OwnableUpgradeable, 
        ERC20Upgradeable, PausableUpgradeable, 
        ERC20BurnableUpgradeable, ReentrancyGuardUpgradeable {

    // ==========State variables====================================

    // ==========Events=============================================

    // ==========Constructor========================================
    /// @notice replacement of `constructor` for upgradeable contracts
    function initialize(string memory _name, string memory _symbol) public initializer {
        __Ownable_init();
        __ERC20_init(_name, _symbol);
        __ERC20Burnable_init();

        _mint(_msgSender(), 1_000_000 * (10 ** uint256(decimals())));       // mint 1M tokens
    }

    // ==========Functions==========================================
    /**
     * @notice Mints given amount of tokens to recipient
     * @dev only owner can call this mint function
     * @param recipient address of account to receive the tokens
     * @param amount amount of tokens to mint
     * @return true if the function executes
     */
    function mint(address recipient, uint256 amount) external payable whenNotPaused onlyOwner nonReentrant returns (bool) {
        require(amount != 0, "amount == 0");
        _mint(recipient, amount);

        return true;
    }

    /// @notice burn function
    /// @param from token owner address
    /// @param amount mint amount
    function burn(address from, uint256 amount) external whenNotPaused nonReentrant returns (bool) {
        _burn(from, amount);

        return true;
    }

}