_Note: This repo has been recently updated for Sepolia_

# Foundry Starter Kit

<br/>
<p align="center">
<a href="https://chain.link" target="_blank">
<img src="./img/chainlink-foundry.png" width="225" alt="Chainlink Foundry logo">
</a>
</p>
<br/>

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/smartcontractkit/foundry-starter-kit)

Foundry Starter Kit is a repo that shows developers how to quickly build, test, and deploy smart contracts with one of the fastest frameworks out there, [foundry](https://github.com/gakonst/foundry)!

- [Foundry Starter Kit](#foundry-starter-kit)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
  - [Testing](#testing)
- [Deploying to a network](#deploying-to-a-network)
  - [Setup](#setup)
  - [Deploying](#deploying)
    - [Working with a local network](#working-with-a-local-network)
    - [Working with other chains](#working-with-other-chains)
- [Security](#security)
- [Contributing](#contributing)
- [Thank You!](#thank-you)
  - [Resources](#resources)
    - [TODO](#todo)

# Getting Started

## Requirements

Please install the following:

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you've done it right if you can run `git --version`
- [Foundry / Foundryup](https://github.com/gakonst/foundry)
  - This will install `forge`, `cast`, and `anvil`
  - You can test you've installed them right by running `forge --version` and get an output like: `forge 0.2.0 (f016135 2022-07-04T00:15:02.930499Z)`
  - To get the latest of each, just run `foundryup`

## Quickstart

```sh
git clone https://github.com/smartcontractkit/foundry-starter-kit
cd foundry-starter-kit
```

## Install dependencies as follows:

Run `forge install` to install dependencies. [Foundry uses git submodules](https://book.getfoundry.sh/projects/dependencies) as its dependency management system.

> ⚠️  when running forge install, you may see an error message if you have uncomitted changes in your repo.  Read the message carefully - it may inform you that you can add the `--no-commit` flag to each of these `install` commands if your workspace has uncommitted changes.

You can update dependencies by running `forge update`

## Testing
To check that everything is compiling and working as intended after cloning and installing dependencies, run
```
forge test
```

All tests should pass.

# Chainlink Foundry Starter Kit

Implementation of the following 4 Chainlink services using the [Foundry] (https://book.getfoundry.sh/) smart contract development tooling:

- [Chainlink Price Feeds](https://docs.chain.link/docs/using-chainlink-reference-contracts)
- [Chainlink VRF V2](https://docs.chain.link/docs/chainlink-vrf)
- [Chainlink Automation](https://docs.chain.link/chainlink-automation/introduction)

For [Chainlink Functions](https://docs.chain.link/chainlink-functions) please go to these starter kits: [Hardhat](https://github.com/smartcontractkit/functions-hardhat-starter-kit) | [Foundry (coming soon)](https://github.com/smartcontractkit/functions-foundry-starter-kit)

For [Chainlink CCIP (Cross Chain Interoperability Prototocol)](https://docs.chain.link/ccip) please go to these starter kits: [Hardhat](https://github.com/smartcontractkit/ccip-starter-kit-hardhat) | [Foundry](https://github.com/smartcontractkit/ccip-starter-kit-foundry)

# Deploying to a network

Deploying to a network uses the [foundry scripting system](https://book.getfoundry.sh/tutorials/solidity-scripting.html), where you write your deploy scripts in solidity!

## Setup

We'll demo using the Sepolia testnet. (Go here for [testnet sepolia ETH](https://faucets.chain.link/).)

You'll need to add the following variables to a `.env` file:

- `SEPOLIA_RPC_URL`: A URL to connect to the blockchain. You can get one for free from [Infura](https://www.infura.io/) account
- `PRIVATE_KEY`: A private key from your wallet. You can get a private key from a new [Metamask](https://metamask.io/) account
  - Additionally, if you want to deploy to a testnet, you'll need test ETH and/or LINK. You can get them from [faucets.chain.link](https://faucets.chain.link/).
- Optional `ETHERSCAN_API_KEY`: If you want to verify on etherscan

When you've added your environment variables to the `.env` file, run `source .env` in your terminal (and for each new terminal session) to load the environment variables into your terminal.

## Deploying

Deploy scripts are in `./script`. The relevant Chainlink Service can be determined from the name of the Contract script. `HelperConfig` is not meant to be deployed.

To deploy one of the Chainlink Service consumer contracts run the script as follows:

```
forge script script/${CONTRACT_NAME}.s.sol:Deploy${CONTRACT_NAME} --rpc-url $SEPOLIA_RPC_URL  --private-key PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY  -vvvv
make deploy-sepolia contract=<CONTRACT_NAME>
```

For example, to deploy the `PriceFeedConsumer` contract:

```
forge script script/PriceFeedConsumer.s.sol:DeployPriceFeedConsumer  --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY -vvvv
```

If you don't have an `ETHERSCAN_API_KEY`, you can omit `--verify --etherscan-api-key $ETHERSCAN_API_KEY`


### Working with Anvil local development network

Foundry comes with local network [anvil](https://book.getfoundry.sh/anvil/index.html) baked in, and allows us to deploy to our local network for quick testing locally.

To start a local network run the following in a new terminal window or tab:

```
anvil
```

This will spin up a local blockchain on `http://localhost:8545` :  (see console output for the mnemonic used, and 10 private keys and their associated wallet address), so you can use the same private key each time.

Then, you can deploy to it with one of those private keys; in this example we use the first one:

```
forge script script/${contract}.s.sol:Deploy${contract} --rpc-url http://localhost:8545  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast 
```


### Working with other chains

To add a chain, you'd just need to pass in the RPC URL for the relevant chain to the `--rpc-url` flag.

```
forge script script/${contract}.s.sol:Deploy${contract} --rpc-url ${<OTHER_CHAIN>_RPC_URL}  --private-key ${PRIVATE_KEY} --broadcast -vvvv

```

# Security

This framework comes with slither parameters, a popular security framework from [Trail of Bits](https://www.trailofbits.com/). To use slither, you'll first need to [install python](https://www.python.org/downloads/) and [install slither](https://github.com/crytic/slither#how-to-install).

Then, you can run:

```
make slither
```

And get your slither output.

# Contributing

Contributions are always welcome! Open a PR or an issue!
If you do contribute please add `solidity.formatter": "forge` to your VSCode Settings, or run `forge fmt` before you commit and push.

# Thank You!

## Resources

- [Chainlink Documentation](https://docs.chain.link/)
- [Foundry Documentation](https://book.getfoundry.sh/)

### TODO

[ ] Add bash scripts to interact with contracts using `cast`

[ ] Make deploying contracts to `anvil` simpler
