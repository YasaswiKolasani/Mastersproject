// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Student {
    struct Record {
        string studentid;
        string name;
        string role;
        uint gpa;
        uint attendence;
        uint scholarship;
    }
    
    mapping (string => Record) records;
    uint public recordCount;
    uint public scholarship;
    address public owner;
    address[] public allowedAddresses;
    string[] private recordKeys;
    
    constructor(uint new_scholarship) {
        assert(new_scholarship >= 1000);
        scholarship=new_scholarship;
        owner = msg.sender;
    }

    modifier onlyAllowed {
        bool isAllowed = false;
        for (uint i = 0; i < allowedAddresses.length; i++) {
            if (msg.sender == allowedAddresses[i]) {
                isAllowed = true;
                break;
            }
        }
        require(isAllowed, "Access denied. You are not allowed to call this function.");
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Access denied. You are not the owner.");
        _;
    }

    function addAddress(address newAddress) public onlyOwner {
        allowedAddresses.push(newAddress);
    }

    function getAddresses() public view onlyOwner returns (address[] memory) {
        return allowedAddresses;
    }
    function createRecord(string memory _studentid, string memory _name,string memory _role, uint _gpa, uint _attendence) public onlyAllowed {
        //require(keccak256(abi.encodePacked(records[_name].name )) == keccak256(abi.encodePacked(_name)), "Record already exists");
        uint _scholarship=0;
        require(scholarship > 0, "Set the scholarship first, to create a record");
        if(_gpa>300 && _attendence>750)
            _scholarship = scholarship;
        Record memory newRecord = Record(_studentid, _name, _role, _gpa, _attendence, _scholarship);
        records[_studentid] = newRecord;
        recordCount++;
        recordKeys.push(_studentid);
    }
    
    function updateRecord(string memory _studentid, string memory _name, string memory _role, uint _gpa, uint _attendence) public onlyAllowed {
        Record storage recordToUpdate = records[_studentid];
        recordToUpdate.name = _name;
        recordToUpdate.gpa = _gpa;
        recordToUpdate.role = _role;
        recordToUpdate.attendence = _attendence;
        if(_gpa>300 && _attendence>750 && recordToUpdate.scholarship == 0)
            recordToUpdate.scholarship = scholarship;
    }
    
    function setScholarship(uint new_scholarship) public onlyAllowed {
        assert(new_scholarship >= 1000);
        scholarship=new_scholarship;
    }

    function getRecordKeys() public view returns (string[] memory) {
        return recordKeys;
    }

    function getRecord(string memory _studentid) public view returns (string memory, string memory, string memory, uint, uint, uint) {
        Record memory record = records[_studentid];
        return (record.studentid, record.name, record.role, record.gpa, record.attendence, record.scholarship);
    }
    
    function getAllRecords() public view returns (Record[] memory) {
        Record[] memory allRecords = new Record[](recordKeys.length);
        for (uint i = 0; i < recordKeys.length; i++) {
            allRecords[i] = records[recordKeys[i]];
        }
        return allRecords;
    }

    function deleteRecord(string memory _studentid) public onlyOwner {
        delete records[_studentid];
    }
}
