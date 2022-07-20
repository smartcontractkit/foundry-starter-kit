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
        chainIdToNetworkConfig[4] = getRinkebyEthConfig();
        chainIdToNetworkConfig[31337] = getAnvilEthConfig();

        activeNetworkConfig = chainIdToNetworkConfig[block.chainid];
    }

    function getRinkebyEthConfig()
        internal
        pure
        returns (NetworkConfig memory rinkebyNetworkConfig)
    {
        rinkebyNetworkConfig = NetworkConfig({
            oracle: 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8,
            jobId: "6b88e0402e5d415eb946e528b8e0c7ba",
            chainlinkFee: 1e17,
            link: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709,
            updateInterval: 60, // every minute
            priceFeed: 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e, // ETH / USD
            subscriptionId: 0, // UPDATE ME!
            vrfCoordinator: 0x6168499c0cFfCaCD319c818142124B7A15E857ab,
            keyHash: 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc
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
