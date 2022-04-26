pragma solidity ^0.5.0;

contract UserCrud {

   struct  UserStruct {
    string userEmail;
    string ruserEmail;
    uint price;
    uint qtty;
    string fromAddr;
    string toAddr;
    uint time ;
    uint index;

  }
  
  address public userAddress;
  mapping(address => UserStruct) private userStructs;

  address[] private userIndex;


 event LogNewUser   (address indexed userAddress,
  uint index, 
  string userEmail,
    string ruserEmail,
    uint price,
    uint qtty,
    string fromAddr,
    string toAddr,
    uint time );

     constructor() public{
        userAddress= msg.sender;
    }





  function isUser()
    public 
    view
    returns(bool isIndeed) 
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].index] == userAddress);
  }



function insertUser(
    string memory userEmail,
    string memory ruserEmail,
    uint price,
    uint qtty,
    string memory fromAddr,
    string  memory toAddr,
    uint time ) 
    public
    returns(uint index)
  {
   
   userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].ruserEmail = ruserEmail;
    userStructs[userAddress].price   = price;
    userStructs[userAddress].qtty   = qtty;
    userStructs[userAddress].fromAddr  = fromAddr;
    userStructs[userAddress].toAddr  = toAddr;
    userStructs[userAddress].time  = time;
    userStructs[userAddress].index     = userIndex.push(userAddress)-1;
    emit LogNewUser(
        userAddress, 
        userStructs[userAddress].index,     
  userEmail,
   ruserEmail,
   price,
    qtty,
    fromAddr,
    toAddr,
     time );

        
    return userIndex.length-1;
  }
  
 

  function getUserCount() 
    public
    view
    returns(uint count)
  {
    return userIndex.length;
  }

  function getUserAtIndex(uint index)
    public
    view
    returns(address userAddresses)
  {
    return userIndex[index];
  }
}
