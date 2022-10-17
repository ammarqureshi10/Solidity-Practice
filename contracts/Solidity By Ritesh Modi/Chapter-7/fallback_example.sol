// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract FallbackExample {
    uint256 public fallbackHitCount = 0;
    event ReceiveLog(address From, uint256 amount);
     event message(string);

    fallback() external payable {
        if(msg.value > 0 ){
            emit ReceiveLog(msg.sender, msg.value);
            emit message("Fallback with Value!");
            fallbackHitCount++;
        }
        else {
            emit message("Fallback without Value!");
            fallbackHitCount++;
        }
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }
}

contract Client {
    address contractAddr;
    constructor(address _contractAddr){
        contractAddr = _contractAddr;
    }

    function callFunction() public returns(bool,bytes memory){
        (bool success, bytes memory data) = contractAddr.call(abi.encodeWithSignature("getBalance()"));
        return (success, data);
    }

    function callWrongFunction() public returns(bool,bytes memory){
        (bool success, bytes memory data) = contractAddr.call(abi.encodeWithSignature("getBalance1()"));
        return (success, data);
    }

    function callWrongFunctionWithValue() public payable returns(bool,bytes memory){
        (bool success, bytes memory data) = contractAddr.call{value: msg.value}(abi.encodeWithSignature("getBalance1()"));
        return (success, data);
    }

}