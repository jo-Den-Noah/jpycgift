// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
//abstract contract KittyInterface{
//    function transfer(address recipient, uint256 amount) external virtual view returns (bool check);
//}


contract JPYCGIFTCARD is ERC721,Pausable,Ownable{

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    MyToken  public cntAddr;

    constructor() ERC721("jpycgiftcard",  "1000jgc")public {
    address ckAddress = 0x431D5dfF03120AFA4bDf332c61A6e1766eF37BDB;
    
    cntAddr = MyToken(ckAddress);}

     function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmUmt99mLhV9mhcxtSfx8hVQjXLma2LNEboFQQEVo6wQCC";
    }
    bool check;
    function safeMint() public payable{
      cntAddr.transferFrom(msg.sender,address(this),1000000000000000000000);
      cntAddr.increaseAllowance(address(this),1000000000000000000000);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
        approve(address(this),tokenId);
        require (tokenId < 10000);
        
    }
    function safeburn(uint tokenId)public payable{
      cntAddr.transferFrom(address(this),msg.sender,1000000000000000000000);
      

      _transfer(msg.sender,0x000000000000000000000000000000000000dEaD, tokenId );
    }
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
      
    function jpycapprove()public{
        cntAddr.approve(address(this),1000000000000000000000000000);
    }
}

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
