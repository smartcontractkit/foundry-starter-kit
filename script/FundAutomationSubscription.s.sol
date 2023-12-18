// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "@chainlink-toolkit/automation/Automation.s.sol";

contract FundAutomationSubscription is Script {
  function run(
    address keeperRegistryAddress,
    uint256 upkeepId,
    uint96 amountInJuels
  ) external returns (bytes32 requestHash){

    AutomationScript automationScript = new AutomationScript(keeperRegistryAddress);

    vm.broadcast();
    return automationScript.addFunds(
      upkeepId,
      amountInJuels
    );
  }
}
