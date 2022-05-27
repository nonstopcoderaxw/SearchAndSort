//SPDX-License-Identifier: unlicenced
pragma solidity 0.8.7;
import "./AXWInsertionSort.sol";

contract ExampleAXWInserationSort {

    using AXWInsertionSort for uint256[];

    uint256[] public array;
    uint256 lastSortedTo;


    constructor() {
        array = [992,837,743,332,883,101,5,938];
    }
    
    
    function dynamicSort(bool asc) public returns (uint256[] memory) {
        //sort
        sort(asc);
        //add more item into the array
        add(1024);
        //this will continue sorting instead of sorting from the begining
        sort(asc);
        //add more item
        add(424);
        //continue to sort
        sort(asc);

        return array;

    }
    
    //gasUsed 18168
    function sort(bool asc) public returns (uint256[] memory sorted, uint256 gasUsed){
        uint256 len = array.length;
        uint256[] memory _array = new uint256[](len);

        for(uint256 i = 0; i < len; i++) {
            _array[i] = array[i];
        }
        
        uint256 gasleft0 = gasleft();
        
        sorted = _array.insertionSort(0, asc);
        
        uint256 gasleft1 = gasleft();
        
        gasUsed = gasleft0 - gasleft1;
        array = sorted;
        lastSortedTo = len--;
    }

    function add(uint256 x) public {
        array.push(x);
    }

    function read() public view returns (uint256[] memory) {
        return array;
    }
}
