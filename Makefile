-include .env

all: install 

install :; forge install smartcontractkit/chainlink-brownie-contracts && forge install rari-capital/solmate

test :; forge test 

snapshot :; forge snapshot

slither :; slither ./src 