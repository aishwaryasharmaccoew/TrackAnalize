pragma solidity ^0.5.0;

contract Auction {
    address  public beneficiary;
    uint cnt;
    // Current state of the auction. You can create more variables if needed
 
    address public highestBidder;
    uint public highestBid;
    

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // Constructor
    constructor() public {
        beneficiary = msg.sender;   
        highestBid=0;    
        cnt=1;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The value will only be refunded if the
    /// auction is not won.

    function bid() public payable {


        // TODO If the bid is not higher than highestBid, send the
        // money back. Use "require"
        if(highestBid==0)
            {
                        highestBidder=msg.sender;
                        highestBid=msg.value;
            }
            else{

                require (msg.value > highestBid,"The bid is not higher that highest bid");        
                // TODO update state
                pendingReturns[highestBidder] = highestBid;

                highestBidder= msg.sender;
                highestBid=msg.value;
            }

        // TODO store the previously highest bid in pendingReturns. That bidder
        // will need to trigger withdraw() to get the money back.
        // For example, A bids 5 ETH. Then, B bids 6 ETH and becomes the highest bidder. 
        // Store A and 5 ETH in pendingReturns. 
        // A will need to trigger withdraw() later to get that 5 ETH back.

        // Sending back the money by simply using
        // highestBidder.send(highestBid) is a security risk
        // because it could execute an untrusted contract.
        // It is always safer to let the recipients
        // withdraw their money themselves.
        //truffle withdrawal error required
    }

    /// Withdraw a bid that was overbid.
    function withdraw() public returns (bool) {
            uint val = pendingReturns[msg.sender];
            bool status= msg.sender.send(val);
            require(status,"Error in returning the amount");
            return status;     
        // TODO send back the amount in pendingReturns to the sender. Try to avoid the reentrancy attack. Return false if there is an error when sending
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() public {
        // TODO make sure that only the beneficiary can trigger this function. Use "require"
        require(cnt==1, "Auction already ended , auctionEnd can be called only once");
        cnt=0;
        require(msg.sender == beneficiary, "Only the beneficiary can trigger this function");

        msg.sender.transfer(highestBid);
        // TODO send money to the beneficiary account. Make sure that it can't call this auctionEnd() multiple times to drain money
    }
}