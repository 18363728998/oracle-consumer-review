// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface ISwarmFeed {
    function latestValue() external view returns (uint256 value, uint64 updatedAt);
}

/// @notice Records the newest value a feed has accepted, and refuses to move backwards.
contract OracleConsumer {
    ISwarmFeed public immutable feed;
    uint256 public value;
    uint64 public updatedAt;

    constructor(ISwarmFeed feed_) {
        feed = feed_;
    }

    function pull() external {
        (uint256 v, uint64 t) = feed.latestValue();
        require(t > updatedAt, "stale");
        value = v;
        updatedAt = t;
    }
}
