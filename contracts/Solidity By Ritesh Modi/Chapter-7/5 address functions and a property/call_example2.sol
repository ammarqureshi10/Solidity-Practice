// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Demo {
    // fallback() external  payable {}
    // receive() external payable {}
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}
contract CallPractice{
    fallback() external  payable {}
    receive() external payable {}
    event Transfer(address From, address To, uint256 amount);
    event LogMessage(string);
    bool public status;

    // address.call to get owner address from Contract `Demo`
    function getOwner(address tokenAddress) internal returns(address addr){
        // address addr;
        (bool success, bytes memory data) = (tokenAddress).call(abi.encodeWithSignature("owner()"));
        if(success){
            addr = abi.decode(data, (address));
            return addr;
        }
        else {
            addr = address(0);
            return addr;
        }
    }
    
    // First get owner address then transfer ETH 
    function transferFund(address tokenAddress) public payable {
        require(msg.value > 0, "Invalid msg.value to transfer");
        (address to) = getOwner(tokenAddress);
        payable(to).transfer(msg.value);
        emit Transfer(msg.sender,to, msg.value);
    }
}