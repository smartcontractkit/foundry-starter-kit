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
        bytes32 keyHash;
    }

    mapping(uint256 => NetworkConfig) public chainIdToNetworkConfig;

    constructor() {
        chainIdToNetworkConfig[5] = getGoerliEthConfig();
        chainIdToNetworkConfig[31337] = getAnvilEthConfig();

        activeNetworkConfig = chainIdToNetworkConfig[block.chainid];
    }

    function getGoerliEthConfig()
        internal
        pure
        returns (NetworkConfig memory goerliNetworkConfig)
    {
        goerliNetworkConfig = NetworkConfig({
            oracle: 0xCC79157eb46F5624204f47AB42b3906cAA40eaB7,
            jobId: "ca98366cc7314957b8c012c72f05aeeb",
            chainlinkFee: 1e17,
            link: 0x326C977E6efc84E512bB9C30f76E30c160eD06FB,
            updateInterval: 60, // every minute
            priceFeed: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e, // ETH / USD
            subscriptionId: 0, // UPDATE ME!
            vrfCoordinator: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D,
            keyHash: 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15
        });
    }

    function getAnvilEthConfig()
        internal
        pure
        returns (NetworkConfig memory anvilNetworkConfig)
    {
        anvilNetworkConfig = NetworkConfig({
            oracle: address(0), // This is a mock
            jobId: "6b88e0402e5d415eb946e528b8e0c7ba",
            chainlinkFee: 1e17,
            link: address(0), // This is a mock
            updateInterval: 60, // every minute
            priceFeed: address(0), // This is a mock
            subscriptionId: 0,
            vrfCoordinator: address(0), // This is a mock
            keyHash: 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc
        });
    }
}
