pragma solidity 0.8.16;

contract demoAssert {
    // assert should be used for validating the current state and condition 
    // of the function and contract before execution.


    function Subtract(uint a, uint b) pure returns(uint256){
        require(a >= b, "invalid denomenator");
        uint256 result = a / b;
        assert(result >= 0); // additional check just

        return result;
    }
}