// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
contract EtherBox {
    uint public balance = 10;
    function setBalance(uint256 amount) public payable{
        balance += amount;
    }
}
contract Client {
    
    //EtherBox contractInstance = new EtherBox();
    //address contrAddress = address(contractInstance);
    address contrAddress;
    constructor(address addr) {
        contrAddress = addr;
    }

    function SimpleCall() public returns(bool,bytes memory) {
        (bool success,bytes memory data) = contrAddress.call(abi.encodeWithSignature("balance()"));
        return (success,data);
    }
    function SimpleCall2(uint256 amount) public returns(bool,bytes memory){
        (bool success,bytes memory data) = contrAddress.call(abi.encodeWithSignature("setBalance(uint256)",amount));
        return (success,data);
    }

    // call with gas is not working fine
    function SimpleCallWithGas(uint256 amount) public returns(bool, bytes memory){
        (bool success, bytes memory data) = contrAddress.call{gas: 100}(abi.encodeWithSignature("setBalance(uint256)",amount));
        return (success,data);
    }

    function SimpleCallWithValue(uint256 amount) public payable returns(bool,bytes memory){
        (bool success, bytes memory data) = contrAddress.call{value: 1 ether}(abi.encodeWithSignature("setBalance(uint256)",amount));
        return (success,data);
    }

    // As call with gas not working, this function also return false
    function SimpleCallWithGasANDValue(uint256 amount) public payable returns(bool,bytes memory){
        (bool success, bytes memory data) = contrAddress.call{gas: 200,value: 1 ether}(abi.encodeWithSignature("setBalance(uint256)",amount));
        return (success,data);
    }

}