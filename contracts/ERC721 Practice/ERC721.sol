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
        // 2. `from` and `to` must not be zero address
        require(from != address(0), "from is invalid");
        require(to != address(0), "to is invalid");
        // 3. `tokenId` owner should be `from`
        require(ownerOf(tokenId) == from, "owner must be from address");
        // 4. caller must be owner, spender or operator
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
        // 3. msg.sender must be owner or operator
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

    // 1/Nov/22
    function _mint(address _to, uint256 _tokenId) internal returns(bool) {
        // 1. `_tokenId` must not exists
        require(ownerOf(_tokenId == address(0)), "_mint: already exists");
        // 2. `_to` should not be zero address
        require(_to != address(0), "_mint: invalid address");

        // make `to` owner of `_tokenId`
        // increase `to` balance by 1
        _owners[_tokenId] = to;
        _balances[_to] += 1;

        emit Transfer(address(0), _to, _tokenId);
        return true;
    }
    function _burn(uint256 _tokenId) internal returns(bool) {
        // 1. `_tokenId` must exists
        require(ownerOf(_tokenId != address(0)), "_burn: non existing tokenId");
        // 2. caller should be owner of _tokenId
        require(msg.sender == ownerOf(_tokenId), "_burn: caller must be owner");

        // make zero address owner of `_tokenId`
        // decrease msg.sender balance by 1
        // Clear approvals from the previous owner
        _owners[_tokenId] = address(0);
        _balances[msg.sender] -= 1;
        delete _allowances[_tokenId];

        emit Transfer(address(0), _to, _tokenId);
        return true;
    }

}