// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Student {
    struct Record {
        string studentid;
        string firstName;
        string lastName;
        string role;
        uint gpa;
        uint gre;
        bool os;
        bool ads;
        bool se;
        bool dme;
        uint scholarship;
    }
    
    mapping (string => Record) records;
    uint public recordCount;
    uint public scholarship;
    address public owner;
    address[] public allowedAddresses;
    string[] private recordKeys;
    
    constructor(uint new_scholarship) {
        require(new_scholarship>=1000, "Scholarship should be atleast 1000");
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
        if(msg.sender == owner)
            isAllowed = true;
        if(isAllowed==false)
            require(false, "Access denied. You are not allowed to call this function.");
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Access denied. You are not the owner.");
        _;
    }

    function addAddress(address newAddress) public onlyOwner {
        uint check=0;
        for (uint i = 0; i < allowedAddresses.length; i++) 
            {
                if (allowedAddresses[i] == newAddress) {
                    check=1;
                    break;
                }
            }
        if(check==1)
            require(false,"Address already exists in the list");
        else
            allowedAddresses.push(newAddress);
    }

    function deleteAddress(address newAddress) public onlyOwner {
        uint check=0;
        for (uint i = 0; i < allowedAddresses.length; i++) 
        {
            if (allowedAddresses[i] == newAddress) 
                {
                    if (i < allowedAddresses.length - 1)
                        allowedAddresses[i] = allowedAddresses[allowedAddresses.length - 1];     
                    allowedAddresses.pop();
                    check = 1;
                    break;
                }
        }
        if(check==0)
            require(false,"Address not found in the list");
    }

    function getAddresses() public view onlyOwner returns (address[] memory) {
        return allowedAddresses;
    }
    function createRecord(string memory _studentid, string memory _firstName, string memory _lastName, string memory _role, uint _gpa, uint _gre, bool _os, bool _ads, bool _se) public onlyAllowed {
        //require(keccak256(abi.encodePacked(records[_studentid].studentid )) == keccak256(abi.encodePacked(_studentid)), "Student already exists");
        require(scholarship > 0, "Set the scholarship first, to create a record");
        uint _scholarship=0;
        bool _dme=true;
        if(_gpa>=300 && _gre>=300)
            _scholarship = scholarship;
        if(_os==true && _ads==true && _se==true)
            _dme=false;
        Record memory newRecord = Record(_studentid, _firstName, _lastName, _role, _gpa, _gre, _os, _ads, _se, _dme, _scholarship);
        records[_studentid] = newRecord;
        recordCount++;
        recordKeys.push(_studentid);
    }
    
    function updateRecord(string memory _studentid, string memory _firstName, string memory _lastName, string memory _role, uint _gpa, uint _gre, bool _os, bool _ads, bool _se) public onlyAllowed {
        Record storage recordToUpdate = records[_studentid];
        recordToUpdate.firstName = _firstName;
        recordToUpdate.lastName = _lastName;
        recordToUpdate.gpa = _gpa;
        recordToUpdate.role = _role;
        recordToUpdate.gre = _gre;
        recordToUpdate.os = _os;
        recordToUpdate.ads = _ads;
        recordToUpdate.se = _se;
        if(_gpa>=300 && _gre>=300 && recordToUpdate.scholarship == 0)
            recordToUpdate.scholarship = scholarship;
        if(_os==true && _ads==true && _se==true)
            recordToUpdate.dme = false;
        else
            recordToUpdate.dme = true;
    }
    
    function setScholarship(uint new_scholarship) public onlyAllowed {
        require(new_scholarship >=1000, "Scholarship should be more than or equal to $1000");
        scholarship=new_scholarship;
    }

    function getRecordKeys() public view returns (string[] memory) {
        return recordKeys;
    }

    function getRecord(string memory _studentid) public view returns (string memory, string memory, string memory, string memory, uint, uint, bool, bool, bool, bool, uint) {
        Record memory record = records[_studentid];
        return (record.studentid, record.firstName,record.lastName, record.role, record.gpa, record.gre, record.os, record.ads, record.se, record.dme, record.scholarship);
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
