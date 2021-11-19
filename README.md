# evm_contracts_tokenupgradeable
Upgradeable token contract for EVM Blockchains

## About
* It's a upgradeable token contract for which mints equal amount of ERC20 token when receives ETH.
* It also burns the token & give 90% of ETH tokens back.
* [Instruction](./instruction.md)
 
## Installation
```console
$ npm i
```

## Usage

### Build
```console
$ npx hardhat compile
```

### Test
```console
$ npx hardhat test
```

### Deploying contracts to localhost Hardhat EVM
#### localhost
```console
// on terminal-1
$ npx hardhat node

// on terminal-2
$ npx hardhat run deployment/hardhat/deploy.ts --network localhost
```


### Deploying contracts to Testnet (Public)
#### ETH Testnet - Rinkeby
* Environment variables
  - Create a `.env` file with its values:
```
INFURA_API_KEY=[YOUR_INFURA_API_KEY_HERE]
DEPLOYER_PRIVATE_KEY=[YOUR_DEPLOYER_PRIVATE_KEY_without_0x]
REPORT_GAS=<true_or_false>
```

* Deploy the contracts
```console
$ npx hardhat run deployment/testnet/rinkeby/deploy.ts  --network rinkeby
```

### Deploying contracts to Mainnet
#### ETH Mainnet
* Environment variables
  - Create a `.env` file with its values:
```
INFURA_API_KEY=[YOUR_INFURA_API_KEY_HERE]
DEPLOYER_PRIVATE_KEY=[YOUR_DEPLOYER_PRIVATE_KEY_without_0x]
REPORT_GAS=<true_or_false>
```

* Deploy the token on one-chain
```console
$ npx hardhat run deployment/mainnet/ETH/deploy.ts  --network mainnet
```
