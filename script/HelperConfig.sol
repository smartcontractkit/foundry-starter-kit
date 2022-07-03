// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

contract HelperConfig {

    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address oracle;
        bytes32 jobId;
        uint256 chainlinkFee;
        address link;
        uint256 updateInterval; 
        address priceFeed; 
        uint64 subscriptionId;
        address vrfCoordinator;
        bytes32 keyHash
    }

    mapping(uint256 => NetworkConfig) public chainIdToNetworkConfig;

    constructor(){
        chainIdToNetworkConfig[4] = getRinkebyEthConfig();

        activeNetworkConfig = chainIdToNetworkConfig(block.chainId);
    }

    function getRinkebyEthConfig() internal returns(NetworkConfig rinkebyNetworkConfig){
        rinkebyNetworkConfig = NetworkConfig(
            {
                oracle: 0xc57b33452b4f7bb189bb5afae9cc4aba1f7a4fd8,
                jobId: "6b88e0402e5d415eb946e528b8e0c7ba",
                chainlinkFee: 1e17,
                link: 0x01be23585060835e02b77ef475b0cc51aa1e0709,
                updateInterval: 60, // every minute
                priceFeed: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e, // ETH / USD 
                subscriptionId: 0, // UPDATE ME!
                vrfCoordinator: 0x6168499c0cFfCaCD319c818142124B7A15E857ab,
                keyHash: "0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc"
            }
        )
    }
}
