// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DemoSend {
    constructor() payable {}

    fallback() external payable {}
    function sendToCaller() external returns(bool) {
        return payable(msg.sender).send(1);
    }

    function contractBalance() public view returns(uint256){
        return address(this).balance;
    }
}