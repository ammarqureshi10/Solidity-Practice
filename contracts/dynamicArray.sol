pragma solidity 0.8.16;
contract DynamicArray {
   uint[] public arr = [2,30,19];

   constructor() {
    set();
    }

    // this function will lead to `Run time Error`
    // because we putting data on index which isnt exists
    // function set() public returns(uint[] memory){
    //     arr[3] = 30; // Run time Error here
    //     return arr;
    // }

    // But we can do same here with push(), and it will work fine LOL!
    // function set() public returns(uint[] memory){
    //     arr.push(3);
    //     return arr;
    // }

 // Another example:
 // Trying to add 3 and 4 in [2,30,19]
    
    // wrong way
    // function set() public {
    //     for (uint i = 3; i < 5; i++){
    //         arr[i] = i; // Run time Error
    //         // arr = [2,30,19,3];
    //         // arr = [2,30,19,3,4];
    //     }
    // }

    // right way
    function set() public {
        for (uint i = 3; i < 5; i++){
            arr.push(i);
            // arr = [2,30,19,3];
            // arr = [2,30,19,3,4];
        }
    }

}