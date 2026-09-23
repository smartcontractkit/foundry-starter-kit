// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "@chainlink-toolkit/automation/Automation.s.sol";

contract CreateAutomationSubscription is Script {
  function run(
    address keeperRegistryAddress,
    uint96 amountInJuels,
    string calldata upkeepName,
    string calldata email,
    address upkeepAddress,
    uint32 gasLimit,
    bytes calldata checkData
  ) external returns (bytes32 requestHash){

    AutomationScript automationScript = new AutomationScript(keeperRegistryAddress);

    vm.broadcast();
    return automationScript.registerUpkeep(
      amountInJuels,
      upkeepName,
      email,
      upkeepAddress,
      gasLimit,
      checkData
    );
  }
}
