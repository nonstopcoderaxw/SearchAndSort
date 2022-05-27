//SPDX-License-Identifier: unlicenced
pragma solidity 0.8.7;

library
    AXWSelectionSort {
        
        //@notice sort an array by selection sort algorithm
        //@param array the unsorted array
        //@param asc ascending or descending
        //@return the sorted array
        function selectionSort(uint256[] memory array, 
                               bool asc)
            internal
            pure
            returns (uint256[] memory) 
        {
            uint256 minIndex;
            for(uint256 i = 0; i < array.length; i++) {
                minIndex = i;
                
                for(uint256 j = i + 1; j < array.length; j++) {
                    if(asc ? 
                        array[minIndex] > array[j] : 
                        array[minIndex] < array[j]
                    ) minIndex = j;
                }
                
                swapItem(array, i, minIndex);
            }
            
            return array;
        }
        
        function swapItem(uint256[] memory array, 
                          uint256 from, 
                          uint256 to) 
            private
            pure 
            returns (uint256[] memory)
        {
            if(from == to) return array;
            
            uint256 temp = array[from];
            array[from] = array[to];
            array[to] = temp;
        }

        
}