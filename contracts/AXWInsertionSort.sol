//SPDX-License-Identifier: unlicenced
pragma solidity 0.8.7;

library
    AXWInsertionSort {

        //@notice sort an given array with intertion sort algorithm
        //@params unsorted the unsorted array
        //@params sortedTo the index that the array has been sorted to.The reason for this params is for
        //                 the situation where unsorted has additional item added after a sort operation.
        //                 this will enable the continuation of sorting on top of the previous sort
        //@params asc true for ascending order; false for descending order
        //@return the sorted array
        function insertionSort(uint256[] memory unsorted, 
                               uint256 sortedTo,
                               bool asc)
            internal
            pure
            returns (uint256[] memory)
        {

            require((unsorted.length - sortedTo > 1), "L"); //either sorted or out of bound

            uint256 newIndex;
            uint256 newItem;
            for(uint256 i = (sortedTo + 1); i < unsorted.length; i++) {
                newIndex = i;
                newItem = unsorted[newIndex];

                while(newIndex > 0
                        &&
                        (asc ?
                            unsorted[newIndex - 1] > newItem :
                            unsorted[newIndex - 1] < newItem
                        )
                     )
                {
                    unsorted[newIndex] = unsorted[newIndex - 1];
                    newIndex--;
                }
                unsorted[newIndex] = newItem;
            }

            return unsorted;
        }
}
