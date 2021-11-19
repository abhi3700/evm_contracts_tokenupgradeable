Follow this: https://gist.github.com/xlc/262fcfe58e00d00f1c7e5f93affd2293

Please implement an upgradeable ERC20 smart contract using Solidity and deploy them on Kovan testnet.

You may use https://faucet.metamask.io/ to get some KETH.

Requirements:

Have an owner account that can upgrade the smart contract
Implements ERC20
Anyone can send ETH to this smart contract to mint same amount of ERC20 tokens
Have a kill switch that permanently kills upgrade functionality. Only owner can perform this action.
Deploy this smart contract to Kovan testnet
Make a transaction to send ETH to mint ERC20 token
Upgrade the smart contract to add a feature that allow user to burn ERC20 token and get 90% of the ETH back
Perform kill switch to kill upgrade functionality
Make another transaction to burn ERC20 to receive ETH
Submit all the relevant code, including pre-upgraded contract and all the executed transactions' hash, preferably etherscan links to the transactions
Transaction deploys smart contract
Transaction sends ETH to mint ERC20 token
Transaction performs upgrade
Transaction performs kill switch
Transaction that burn ERC20 token and receive ETH