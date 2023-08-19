// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}

abstract contract InvariantsBase {
    function excludeArtifacts() public view returns (string[] memory) {
        return invariants.getState().excludedArtifacts;
    }

    function excludeContracts() public view returns (address[] memory) {
        return invariants.getState().excludedContracts;
    }

    function excludeSenders() public view returns (address[] memory) {
        return invariants.getState().excludedSenders;
    }

    function targetArtifacts() public view returns (string[] memory) {
        return invariants.getState().targetedArtifacts;
    }

    function targetArtifactSelectors() public view returns (FuzzSelector[] memory) {
        return invariants.getState().targetedArtifactSelectors;
    }

    function targetContracts() public view returns (address[] memory) {
        return invariants.getState().targetedContracts;
    }

    function targetSelectors() public view returns (FuzzSelector[] memory) {
        return invariants.getState().targetedSelectors;
    }

    function targetSenders() public view returns (address[] memory) {
        return invariants.getState().targetedSenders;
    }
}

library invariants {
    struct State {
        address[] excludedContracts;
        address[] excludedSenders;
        address[] targetedContracts;
        address[] targetedSenders;
        string[] excludedArtifacts;
        string[] targetedArtifacts;
        FuzzSelector[] targetedArtifactSelectors;
        FuzzSelector[] targetedSelectors;
    }

    function getState() internal pure returns (State storage state) {
        bytes32 slot = keccak256("vulcan.invariants.state");
        assembly {
            state.slot := slot
        }
    }

    function excludeContract(address newExcludedContract) internal {
        getState().excludedContracts.push(newExcludedContract);
    }

    function excludeSender(address newExcludedSender) internal {
        getState().excludedSenders.push(newExcludedSender);
    }

    function excludeArtifact(string memory newExcludedArtifact) internal {
        getState().excludedArtifacts.push(newExcludedArtifact);
    }

    function targetArtifact(string memory newTargetedArtifact) internal {
        getState().targetedArtifacts.push(newTargetedArtifact);
    }

    function targetArtifactSelector(FuzzSelector memory newTargetedArtifactSelector) internal {
        getState().targetedArtifactSelectors.push(newTargetedArtifactSelector);
    }

    function targetContract(address newTargetedContract) internal {
        getState().targetedContracts.push(newTargetedContract);
    }

    function targetSelector(FuzzSelector memory newTargetedSelector) internal {
        getState().targetedSelectors.push(newTargetedSelector);
    }

    function targetSender(address newTargetedSender) internal {
        getState().targetedSenders.push(newTargetedSender);
    }
}
