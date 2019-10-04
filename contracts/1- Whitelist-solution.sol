pragma solidity ^0.5.0;

contract Whitelist {

    // 1A- Create state varibales to state user profile:
    // "name" of type string
    // "proffession" of type string
    // "created" of type bool

    // 3A- Create some getter functions to return state variables
    // 3B- Replace getter functions by public variables

    // 4A- Wrap all state varibales "name", "proffession", "created" into a struct named "Profile"
    // 4B- Create a public state variable "user" of type Profile
    // 4C- Assign propeties of "user" inside addUser function by input arguments
    struct Profile {
        string name;
        uint8 age;
        string proffession;
        bool created;
    }

    // 5- Create an array named "userAddresses" of type address
    address[] userAddress;

    // 6- Create a mapping named "users" maps address type to Profile type
    mapping (address => Profile) users;

    // 12- BIG CHALLENGE 2:
    // Create a modifier named "onlyWhitelisted" which requires the message sender profile has been created
    // hint: check "created" property of message sender profile
    modifier onlyWhtielisted() {
        require(users[msg.sender].created == true, "");
        _;
    }

    // 2A- Create a function named "addUser" with input arguments:
    // "_name" of type string
    // "_age" of type 8-bit unsigned integer
    // "_proffession" of type string
    // 2B- Initialize the state variables defined before with ones provided by input arguments
    function addUser(string memory _name, uint8 _age, string memory _proffession) public {
        // 13- HOMEWORK: Use require statement to check input arguments are not empty or equal to 0
        require(keccak256(abi.encodePacked(_name)) != keccak256(abi.encodePacked("")), "name must not be empty!");
        require(keccak256(abi.encodePacked(_age)) != keccak256(abi.encodePacked("")), "email must not be empty!");
        require(keccak256(abi.encodePacked(_proffession)) != keccak256(abi.encodePacked("")), "proffession must not be empty!");

        // 7A- Define "senderAddress" of type address and initilize it with message sender
        // 7B- Get a storage instance of type Profile
        // 7C- Initialize it with the profile of "senderAddress" user
        // hint: get message sender address from "sender" propert of "msg" global variable
        // hint: user users mapping
        Profile storage _profile = users[msg.sender];

        // 10- Require the "created" profile is false, and return the following message at falsy case
        // "Profile with the same address already exists!"
        require(_profile.created == false, "Profile with the same address already exists!");

        // 8A- Assing profile properties ie, "name", "age", "proffession" with input arguments
        // 8B- Assign property "created" as true
        _profile.name = _name;
        _profile.age = _age;
        _profile.proffession = _proffession;
        _profile.created = true;

        // 9- Push the "senderAddress" inot userAddresses array
        userAddress.push(msg.sender);
    }

    // 11- BIG CHALLENGE 1:
    // Create function getUser accepts "userId" of type uint256 and returns user's profile ie, "name", "age", "proffession"
    function getUser(uint256 userId) public view returns (string memory, uint8, string memory) {
        address _userAddress = userAddress[userId];
        Profile memory _profile = users[_userAddress];
        return (_profile.name, _profile.age, _profile.proffession);
    }

}