pragma solidity 0.8.16;

contract demoRequire {
    mapping (uint256 => mapping(address => bool)) public holder;
    uint256 maxTicketPerAddress = 1;
    uint256 ticketPrice = 0.1 ether;

    function purchaseTicket(uint256 movieID,uint256 quantity) external payable returns(bool){
        if(quantity > maxTicketPerAddress){
            revert("Max ticket per address exceeded!");
        }
        if(msg.value < quantity * price){
            revert("Invalid amount!");
        }

        holder[movieID][msg.sender] = true;
    }
    function enterCinema(uint256 movieID) external returns(bool){
        if(holder[movieID][msg.sender] != true){
            revert("Non-purchased user!");
        }

        holder[movieID][msg.sender] = false;
    }

}