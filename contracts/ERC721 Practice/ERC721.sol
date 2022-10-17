pragma solidity 0.8.16;
import "./IERC721.sol";

contract ERC721 is IERC721 {
    // state
    string public name;
    string public symbol;

    mapping (uint256 => string) private uris;

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;

    mapping(uint256 => address) private _allowances;
    mapping(address => mapping (address => bool)) private _approvalForAll;

    constructor() {
        name = "October Fun";
        symbol = "OCT";
    }

    // View functions
    function balanceOf(address account) public override view returns(uint256){
        return _balances[account];
    }
    function ownerOf(uint256 tokenId) public override view returns(address){
        return _owners[tokenId];
    }
    function tokenURI(uint256 tokenId) public override view returns(string memory){
        return uris[tokenId];
    }
    function getApproved(uint256 tokenId) public override view returns(address){
        return _allowances[tokenId];
    }
    function isApprovalForAll(address owner, address operator) public override view returns(bool){
        return _approvalForAll[owner][operator];
    }

    // Write functions
    function transferFrom(address from, address to, uint256 tokenId) external override returns(bool){
        // 1. `tokenId` should exist
        require(ownerOf(tokenId) != address(0), "tokenId not exists");
        // 2. `from` and `to` should not be zero address
        require(from != address(0), "from is invalid");
        require(to != address(0), "to is invalid");
        // 3. `tokenId` owner should be `from`
        require(ownerOf(tokenId) == from, "owner should be from address");
        // 4. caller should be owner, spender or operator
        require(msg.sender == from || msg.sender == getApproved(tokenId) || isApprovalForAll(from,msg.sender), "Invalid caller");

        _balances[from] -= 1;
        _owners[tokenId] = to;
        _balances[to] += 1;

        // Clear approvals from the previous owner
        delete _allowances[tokenId];

        emit Transfer(from, to, tokenId);
        return true;
    }
    function approve(address spender, uint256 tokenId) public override returns(bool){
        // 1. `tokenId` should exist
        require(ownerOf(tokenId) != address(0), "tokenId not exists");
        // 2. `spender` should not be zero address
        require(spender != address(0), "spender is invalid");
        // 3. msg.sender should be owner or operator
        require(msg.sender == ownerOf(tokenId) || isApprovalForAll(ownerOf(tokenId), msg.sender), "invalid caller");
        
        _allowances[tokenId] = spender;

        emit Approval(msg.sender, spender, tokenId);
        return true;
    }
    function setApprovalForAll(address operator, bool approved) external returns(bool){
        // 1. `operator` should not be zero address
        require(operator != address(0), "spender is invalid");

        _approvalForAll[msg.sender][operator] = approved;

        emit ApprovalForAll(msg.sender, operator, approved);
        return true;

    }

}