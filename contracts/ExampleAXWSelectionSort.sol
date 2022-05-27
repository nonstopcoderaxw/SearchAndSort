//SPDX-License-Identifier: unlicenced
pragma solidity 0.8.7;

import "./AXWSelectionSort.sol";

contract ExampleAXWSelectionSort {
    
    using AXWSelectionSort for uint256[];

    uint256[] public array;

    constructor() {
        array = [992,837,743,332,883,101,5,938];
    }
    
    //gasUsed: 14580
    function sort(bool asc) public returns (uint256[] memory sorted, uint256 gasUsed) {
        //copy storage to memory
        sorted = new uint256[](array.length);
        
        for(uint256 i = 0; i < array.length; i++) {
            sorted[i] = array[i];
        }
        
        uint256 gasleft0 = gasleft();
        
        sorted = sorted.selectionSort(asc);
        
        uint256 gasleft1 = gasleft();
        gasUsed = gasleft0 - gasleft1;
        
        array = sorted;
        
    }
    
}
