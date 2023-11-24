// SPDX-License-Identifier: GPL-3.0
pragma solidity > 0.8.16;
import {OwnableUpgradeable} from "@openzeppelin-upgradeable/access/OwnableUpgradeable.sol";
import {IState} from "@contracts/interfaces/IState.sol";
import {ClaimBuilder} from "@contracts/lib/ClaimBuilder.sol";
import {IdentityLib} from "@contracts/lib/IdentityLib.sol";
import {IdentityBase} from "@contracts/lib/IdentityBase.sol";

// /**
//  * @dev Contract managing onchain identity
//  */
contract IdentityExample is IdentityBase, OwnableUpgradeable {
    using IdentityLib for IdentityLib.Data;

    // This empty reserved space is put in place to allow future versions
    // of the State contract to inherit from other contracts without a risk of
    // breaking the storage layout. This is necessary because the parent contracts in the
    // future may introduce some storage variables, which are placed before the State
    // contract's storage variables.
    // (see https://docs.openzeppelin.com/upgrades-plugins/1.x/writing-upgradeable#storage-gaps)
    // slither-disable-next-line shadowing-state
    // slither-disable-next-line unused-state
    uint256[500] private __gap;

    function initialize(address _stateContractAddr) public override initializer {
        super.initialize(_stateContractAddr);
        __Ownable_init();
    }

    function addClaimAndTransit(uint256[8] calldata claim) public onlyOwner {
        addClaim(claim);
        transitState();
    }

    function addClaimHashAndTransit(uint256 hashIndex, uint256 hashValue) public onlyOwner {
        addClaimHash(hashIndex, hashValue);
        transitState();
    }

    function revokeClaimAndTransit(uint64 revocationNonce) public onlyOwner {
        revokeClaim(revocationNonce);
        transitState();
    }

    /**
     * @dev Add claim
     * @param claim - claim data
     */
    function addClaim(uint256[8] calldata claim) public virtual onlyOwner {
        identity.addClaim(claim);
    }

    /**
     * @dev Add claim hash
     * @param hashIndex - hash of claim index part
     * @param hashValue - hash of claim value part
     */
    function addClaimHash(uint256 hashIndex, uint256 hashValue) public virtual onlyOwner {
        identity.addClaimHash(hashIndex, hashValue);
    }

    /**
     * @dev Revoke claim using it's revocationNonce
     * @param revocationNonce - revocation nonce
     */
    function revokeClaim(uint64 revocationNonce) public virtual onlyOwner {
        identity.revokeClaim(revocationNonce);
    }

    /**
     * @dev Make state transition
     */
    function transitState() public virtual onlyOwner {
        identity.transitState();
    }

    /**
     * @dev Calculate IdentityState
     * @return IdentityState
     */
    function calcIdentityState() public view virtual returns (uint256) {
        return identity.calcIdentityState();
    }

    function newClaimData() public pure virtual returns (ClaimBuilder.ClaimData memory) {
        ClaimBuilder.ClaimData memory claimData;
        return claimData;
    }

    /**
     * @dev Builds claim
     * @param claimData - claim data
     * @return binary claim
     */
    function buildClaim(
        ClaimBuilder.ClaimData calldata claimData
    ) public pure virtual returns (uint256[8] memory) {
        return ClaimBuilder.build(claimData);
    }
}