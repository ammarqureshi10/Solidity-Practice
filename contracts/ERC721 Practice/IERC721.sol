pragma solidity 0.8.16;

interface IERC721 {
    // function name() external view returns(string memory);
    // function symbol() external view returns(string memory);

    function balanceOf(address account) external view returns(uint256);
    function ownerOf(uint256 tokenId) external view returns(address);
    function tokenURI(uint256 tokenId) external view returns(string memory);
    // function allowance(address owner, address spender, uint256 tokenId) external view returns(bool);
    function getApproved(uint256 tokenId) external view returns(address);
    function isApprovalForAll(address owner, address operator) external view returns(bool);

    function transferFrom(address from, address to, uint256 tokenId) external returns(bool);
    function approve(address spender, uint256 tokenId) external returns(bool);
    function setApprovalForAll(address operator, bool approved) external returns(bool);
    

    // events
    event Transfer(address from, address to, uint256 tokenId);
    event Approval(address owner, address spender, uint256 tokenId);
    event ApprovalForAll(address owner,address operator, bool approved);
    
}