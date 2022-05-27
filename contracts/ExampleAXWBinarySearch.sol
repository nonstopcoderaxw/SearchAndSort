//SPDX-License-Identifier: unlicenced

pragma solidity 0.8.0;

import "./AXWBinarySearch.sol";

contract ExampleAXWBinarySearch {
    using AXWBinarySearch for uint256[];
    using AXWBinarySearch for int256[];

    function binarySearch(uint256[] memory array,
                          uint256 target)
                          public
                          pure
                          returns (uint256)
    {
        return array.binarySearch(target);
    }

    function binarySearch(int256[] memory array,
                          int256 target)
                          public
                          pure
                          returns (uint256)
    {
        return array.binarySearch(target);
    }

}
