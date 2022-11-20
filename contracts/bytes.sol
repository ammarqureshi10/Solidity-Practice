pragma solidity 0.8.16;
contract BytesDatatype {
    bytes2 public a = "ab"; // 2 byte = 16bit, each character take 8bits

    function get() public view returns(bytes2,bytes2){
        return (a[0],a[1]);
    }

}