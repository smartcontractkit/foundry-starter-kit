// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "@chainlink-toolkit/functions/Functions.s.sol";

contract CreateFunctionsSubscriptionWithConsumer is Script {
  function run(
    address functionsRouterAddress,
    address functionsConsumerAddress,
    address linkTokenAddress,
    uint256 amountInJuels
  ) external returns (uint64 subId){

    FunctionsScript functionsScript = new FunctionsScript(functionsRouterAddress);

    vm.broadcast();
    subId = functionsScript.createSubscriptionWithConsumer(functionsConsumerAddress);

    vm.broadcast();
    functionsScript.fundSubscription(linkTokenAddress, amountInJuels, subId);

    return subId;
  }
}
