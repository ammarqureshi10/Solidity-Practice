pragma solidity 0.8.16;

contract EnumArray {
    enum Subjects {
        Chemistry,
        Physics,
        Maths
    }

    Subjects[] subjects = [Subjects.Chemistry,Subjects.Physics, Subjects.Maths];

    function getArray() public view returns(Subjects[] memory) {
        return subjects;
    }

}