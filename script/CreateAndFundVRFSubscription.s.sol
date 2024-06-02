// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "@chainlink-toolkit/vrf/VRF.s.sol";

contract CreateAndFundVRFSubscription is Script {
  function run(
    address vrfCoordinatorAddress,
    uint96 amountInJuels
  ) external returns (uint64 subId){
    VRFScript vrfScript = new VRFScript(vrfCoordinatorAddress);

    vm.broadcast();
    subId = vrfScript.createSubscription();

    vm.broadcast();
    vrfScript.fundSubscription(amountInJuels, subId);

    return subId;
  }
}
