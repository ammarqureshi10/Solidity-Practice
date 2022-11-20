pragma solidity 0.8.16;
contract StructArray {
    struct Subjects {
        string subjectName;
        uint256 subjectID;
    }
    Subjects[] arr;

    constructor() {
        addSubject("Physics", 1);
    }

    function addSubject(string memory _subjectName, uint256 _subjectID) public {
        // way1
        // Subjects memory subject = Subjects(_subjectName, _subjectID);
        // arr.push(subject);

        // way2
        // Subjects memory subject = Subjects({subjectName: _subjectName, subjectID: _subjectID});
        // arr.push(subject);

        // way3
        arr.push(Subjects(_subjectName, _subjectID));

    }

    function getArray() public view returns(Subjects[] memory){
        return arr;
    }
}