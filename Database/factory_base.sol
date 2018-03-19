/*
Copyright (c) 2018 ZSC Dev Team
*/

pragma solidity ^0.4.18;

import "./db_entity.sol";

contract ZSCDatabase is Object { 
    function getNode(bytes32 _name) public only_delegate constant returns (address);
    function destroyNode(bytes32 _name) public only_delegate returns (bool);
    function destroyNode(address _node) public only_delegate returns (bool);
}

contract FactoryBase is Object {
    address private bindedDB_;
    address private apiController_;

    function FactoryBase(bytes32 _name) public Object(_name) {}

    function setupFactoryRoot() internal;

    function createNode(bytes32 _user, bytes32 _node) public returns (address);

    function getBindedApiController() public only_delegate constant returns (address) { return apiController_;}

    function getBindedDB() public only_delegate constant returns (address) { return bindedDB_;}


    function getNode(bytes32 _name) public only_delegate constant returns (address) {
        return ZSCDatabase(bindedDB_).getNode(_name);
    }

    function initFactory(address _callbackApiController, address _database) public only_delegate  {
        if (_database != 0) bindedDB_ = _database;

        if (_callbackApiController != 0 && _callbackApiController != apiController_) {
            if (apiController_ != 0) {
                setDelegate(apiController_, false);
            }
            apiController_ = _callbackApiController;
            setDelegate(_callbackApiController, true);
        }
        setupFactoryRoot();
    }

    function addNodeParameter(bytes32 _node, bytes32 _parameter) public only_delegate returns (bool) {
        return DBEntity(ZSCDatabase(bindedDB_).getNode(_node)).addParameter(_parameter);
    }
    
    /*
    function getNodeParameter(bytes32 _node, bytes32 _parameter) public only_delegate constant returns (string) {
        return DBEntity(ZSCDatabase(bindedDB_).getNode(_node)).getParameter(_parameter);
    }
    */

    function setNodeParameter(bytes32 _node, bytes32 _parameter, string _value) public only_delegate returns (bool) {
        string memory str = "FactoryBase: setNodeParameter - ";
        str = PlatString.append(str, PlatString.bytes32ToString(_node), " : " );
        str = PlatString.append(str, PlatString.bytes32ToString(_parameter), " : " , _value);
        addLog(str, 1, 1);
        return DBEntity(ZSCDatabase(bindedDB_).getNode(_node)).setParameter(_parameter, _value);
    }

    function numNodeParameters(bytes32 _node) public only_delegate constant returns (uint) {
        address node = ZSCDatabase(bindedDB_).getNode(_node);
        if (node == 0) {
            return 0;
        } 
        return DBEntity(node).numParameters();
    }

    function getNodeParameterNameByIndex(bytes32 _node, uint _index) public only_delegate constant returns (bytes32) {
        return DBEntity(ZSCDatabase(bindedDB_).getNode(_node)).getParameterNameByIndex(_index);
    }
}
