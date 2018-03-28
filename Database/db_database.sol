/*
Copyright (c) 2018 ZSC Dev Team
*/

pragma solidity ^0.4.18;

import "./plat_string.sol";
import "./object.sol";
import "./db_node.sol";
import "./db_idmanager.sol";

contract DBDatabase is Object {
    bytes32 private temp_;
    address private rootNode_ = 0;
    address[] private nodes_;
    mapping(bytes32 => address) private nodeAddress_;

    /*added on 2018-02-25*/
    struct NodeParameterValue {mapping (bytes32 => string) values_; }
    mapping (bytes32 => NodeParameterValue) nodeParameters_;

    function DBDatabase(bytes32 _name) public Object(_name) {
    }

    function initDatabase(address[] _factories) public only_delegate () {
        if (rootNode_ == 0) {
            for (uint i=0; i<_factories.length; i++) {
                setDelegate(_factories[i], true);
            }
            rootNode_ = new DBNode(name());
            setDelegate(rootNode_, true);
            DBNode(rootNode_).setFactoryAndDatabase(_factories, this, 0x0);
        }
    }

    function kill() public only_delegate { 
        destroyNode(rootNode_);
        super.kill();
    }
    
    function getNode(bytes32 _name) public only_delegate constant returns (address) { return nodeAddress_[_name]; }

    function numNodes() public only_delegate constant returns (uint) { return nodes_.length; }

    function getNodeNameByIndex(uint _index) public only_delegate constant returns (bytes32) { 
        if (_index >= nodes_.length) return "null";
        return Object(nodes_[_index]).name(); 
    }

    function _addNode(address _node) public only_delegate {
        require (nodeAddress_[DBNode(_node).name()] == 0);

        nodes_.push(_node);
        nodeAddress_[DBNode(_node).name()] = _node;

        //for testing purpose; 2018-03-06, 2018-03-14
        string memory str = "DBDatabase: _addNode() - ";
        string memory nodeName = PlatString.bytes32ToString(DBNode(_node).name());
        str = PlatString.append(str, nodeName);
        addLog(str, true);
    }

    function _bindId(address _idManager, address _id) public only_delegate returns (address) {
        if (_idManager == 0) {
            DBIDManager idmanager = new DBIDManager();
            idmanager.addId(_id);
            return address(idmanager);
        } else {
            DBIDManager(_idManager).addId(_id);
            return _idManager;
        }
    }

    function _numBindedIds(address _idManager, bytes32 _type) public only_delegate constant returns (uint) {
        uint totalNos = DBIDManager(_idManager).numIds();
        uint typeNos = 0;
        address nd = 0;
        for (uint i = 0; i < totalNos; ++i) {
            nd = DBIDManager(_idManager).getId(i);
            if (DBNode(nd).getNodeType() == _type) {
                typeNos++;
            }
        }
        return typeNos;
    }
    
    function _getBindedIdNameByIndex(address _idManager, bytes32 _type, uint _index) public only_delegate constant returns (bytes32) {
        uint totalNos = DBIDManager(_idManager).numIds();
        uint typeNos = 0;
        address en = 0;
        for (uint i = 0; i < totalNos; ++i) {
            en = DBIDManager(_idManager).getId(i);
            if (DBNode(en).getNodeType() == _type) {
                if (typeNos == _index)
                   return DBNode(en).name();
                typeNos++;
            }
        }
        return "null";
    }

    function destroyNode(address _node) public only_delegate returns (bool) {
        for (uint i = 0; i < nodes_.length; ++i) {
            if (nodes_[i] == _node) {
                address parent = DBNode(nodes_[i]).getParent();
                if (parent != 0) {
                    DBNode(parent).removeChild(DBNode(nodes_[i]).name());
                    DBNode(nodes_[i]).removeAndDestroyAllChildren();
                }
                nodes_[i] = nodes_[nodes_.length - 1];
                break;
            }    
        }
        delete nodes_[nodes_.length - 1];
        nodes_.length --;
            
        delete nodeAddress_[DBNode(_node).name()];
        setDelegate(_node, false);

        delete _node;

        return true;
    }

    function destroyNode(bytes32 _name) public only_delegate returns (bool) {
        address nd = nodeAddress_[_name];
        if (nd == 0) return false;
        return destroyNode(nd);
    }
}
