/*
Copyright (c) 2018, ZSC Dev Team
*/

pragma solidity ^0.4.21;

import "./db_entity.sol";

contract WalletBase is DBNode {
    struct Payment {
        uint time_;
        bool isInput_;
        bytes32 tx_;
        address sender_;
        address receiver_;
        uint256 amount_;
    }
    uint private nos_;
    mapping(uint => Payment) private payments_;

    uint256 private totalValue_;

    // Constructor
    function WalletBase(bytes32 _name) public DBNode(_name) {
        totalValue_= 0;
    }

    ////////// internal functions /////////////
    function changeValue(bool _doesIncrease, uint _amount) internal returns (bool) {
        if (_doesIncrease) {
            totalValue_ = totalValue_.add(_amount);
        } else {
            require(totalValue_ >= _amount);
            totalValue_ = totalValue_.sub( _amount);
        }
    }

    function checkBeforeSent(address _dst, uint _amount) internal constant {
        require(totalValue_ >= _amount && _dst != address(this));
    }

    function recordInput(address _sender, uint _amount) internal {
        uint index = nos_;
        nos_++;
        payments_[index] = Payment(now, false, 0x0, _sender, address(this), _amount);
    }

    function recordOut(address _receiver, uint _amount) internal {
        require(totalValue_ >= _amount);
        uint index = nos_;
        nos_++;
        payments_[index] = Payment(now, true, 0x0, address(this), _receiver, _amount);
    }

    ////////// public functions /////////////
    function getBlance() public constant returns (uint);

    function numTransactions() public constant returns (uint) {
        checkDelegate(msg.sender, 1);
        return nos_;
    }

    function getTransactionInfoByIndex(uint _index) public constant returns (uint, bool, bytes32, uint, address, address) {
        checkDelegate(msg.sender, 1);
        
        require(_index < nos_);
        
        return (payments_[_index].time_,
                payments_[_index].isInput_,
                payments_[_index].tx_,
                payments_[_index].amount_,
                payments_[_index].sender_, 
                payments_[_index].receiver_);
    }
}
