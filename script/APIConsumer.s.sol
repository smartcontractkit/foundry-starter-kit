// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "../src/APIConsumer.sol";
import "./HelperConfig.sol";

contract DeployAPIConsumer is Script {
    function run() external {
        helperConfig HelperConfig = new HelperConfig();

        vm.startBroadcast();

        APIConsumer apiConsumer = new APIConsumer(
            helperConfig.activeNetworkConfig.oracle,
            helperConfig.activeNetworkConfig.jobId,
            helperConfig.activeNetworkConfig.chainlinkFee,
            helperConfig.activeNetworkConfig.link
        );

        vm.stopBroadcast();
    }
}
