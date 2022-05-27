//SPDX-License-Identifier: unlicenced

pragma solidity 0.8.0;

library
    AXWBinarySearch {
    

    ///@notice check if an array is sorted in ascending order
    ///@param array the array to check
    ///@param index the "to index" of the sub array to run recursion, 
    ///       the initial value should the length of the array
    ///@return 0 - unsorted in ascending order
    ///        1 - sorted in ascending order and no duplicated item  
    ///        2 - include duplicated item
    function isAscSortedAndNoDup(uint256[] memory array, uint256 index) internal pure returns (uint256) {
        
        // base case
        if(index == 1) return 1;
        
        //check sorting
        if(array[index - 1] < array[index - 2])  return 0;

        //check dup
        if(array[index - 1] == array[index - 2]) return 2;

        return isAscSortedAndNoDup(array, index - 1);
    }

    ///@notice check to see if an targeted item exists in a sorted array by divide & conquer
    ///@param array the given sorted array
    ///@param target the targeted item to the array
    ///@return true - if exists, false - not found
    function includes(uint256[] memory array,
                          uint256 target)
                          internal
                          pure
                          returns (bool)
    {
        require(array.length < type(uint256).max / 2, "overflow");

        uint256 left;
        uint256 right = array.length - 1;
        uint256 mid;

        while (left <= right) {
            mid = (left + right) / 2; //overflow case captured by "require" above
 
            if (target == array[mid]) return true;

            if (target < array[mid]) {
                right = mid - 1;
                continue;
            }

            left = mid + 1;
        }

        return false;
    }

    ///@notice binary search for a sorted unsigned integer array
    ///@param array the given sorted array
    ///@param target the targeted item to the array
    ///@return the index of the target if found, if not found return the max 256bit number
    function binarySearch(uint256[] memory array,
                          uint256 target)
                          internal
                          pure
                          returns (uint256)
    {
        require(array.length < type(uint256).max / 2, "overflow");

        uint256 left;
        uint256 right = array.length - 1;
        uint256 mid;

        while (left <= right) {
            mid = (left + right) / 2; //overflow case captured by "require" above
 
            if (target == array[mid]) return mid;

            if (target < array[mid]) {
                right = mid - 1;
                continue;
            }

            left = mid + 1;
        }

        return type(uint256).max;
    }

    ///@notice binary search for a sorted unsigned integer array
    ///@param array the given sorted array
    ///@param target the targeted item to the array
    ///@return index the index of the target if found, if not found return the max 256bit number
    function binarySearch_asm(uint256[] memory array,
                          uint256 target)
                          internal
                          pure
                          returns (uint256 index)
    {
        assembly {
            let left := 0
            let right := sub(mload(array), 1)
            let mid
            let midval

            for { } or(lt(left, right), eq(left, right)) { } {
                 mid := div(add(left, right), 2)
                 midval := getItem(mid, array)

                if eq(midval, target) {
                    index := mid
                    break
                }

                if lt(midval, target) {
                    left := add(mid, 1)
                }

                if gt(midval, target) {
                    right := sub(mid, 1)
                }

                if iszero(index) {
                    index := not(1) //max
                }
            }


            function getItem(i, ar) -> item {
                let o := mul(add(i,1), 32)

                let mem := mload(0x40)

                if lt(o, i) { 
                    mstore(mem, "overflow")
                    revert(mem, 32) 
                }  //overflow check

                item := mload(add(ar, o))
            }

        }
    }


    ///@notice binary search for a sorted signed integer array
    ///@param array the given sorted array
    ///@param target the targeted item to the array
    ///@return index the index of the target if found, if not found return the max 256bit number
    function binarySearch_asm(int256[] memory array,
                          int256 target)
                          internal
                          pure
                          returns (uint256 index)
    {
        assembly {
            let left := 0
            let right := sub(mload(array), 1)
            let mid
            let midval

            for { } or(lt(left, right), eq(left, right)) { } {
                 mid := div(add(left, right), 2)
                 midval := getItem(mid, array)


                if eq(midval, target) {
                    index := mid
                    break
                }

                if slt(midval, target) {
                    left := add(mid, 1)
                }

                if sgt(midval, target) {
                    right := sub(mid, 1)
                }

                if iszero(index) {
                    index := not(1) //max
                }
            }


            function getItem(i, ar) -> item {
                let o := mul(add(i,1), 32)

                let mem := mload(0x40)

                if lt(o, i) { 
                    mstore(mem, "overflow")
                    revert(mem, 32) 
                }  //overflow check

                item := mload(add(ar, o))
            }

        }
    }
}
