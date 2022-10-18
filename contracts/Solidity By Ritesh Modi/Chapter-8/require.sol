pragma solidity 0.8.16;

contract demoRequire {
    mapping (address=>bool) public enrolledStudent;

    function enrollStudent() external payable returns(bool){
        require(enrolledStudent[msg.sender] == false, "Already enrolled");
        require(msg.value >= 0.5 ether, "Invalid amount");

        // enroll msg.sender upon fee submission
        enrolledStudent[msg.sender] = true;
    }

}