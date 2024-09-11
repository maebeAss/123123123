pragma solidity >=0.8.2 <0.9.0;

contract MyContract { 
    // function func (uint _i) public pure  returns (bool) {
    //     if (_i % 5 == 0) {
    //     return true;
    // }
    // revert("ERROR");
    // }

    // function func1 (uint _i) public pure returns (bool) {
    //     require(_i % 5 == 0, "ERROR");
    //     return true;
    // }

    // uint256 public num = 90;

    // function testAssert() public view {
    //     assert(num == 100);
    // }

    // function foo() public {
        // num += 1;
    // }

    // error MyError(uint i);

    // function testCusErr(uint _i) public pure returns (bool) {
    //     if (_i % 5 == 0) {
    //         return true;
    //     }
    //     revert MyError(_i);
    // }
    error OwnerError(address addr);

    address public owner;
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    // event Log(address indexed sender, string message);
    // event AnotherLog();

    // function TESTOOOO() public {
    //     emit Log(msg.sender, "Hello World!");
    //     emit Log(msg.sender, "Hello EVM!");
    //     emit AnotherLog();
    // }

    function ownerCheck(address _addr) public onlyOwner view returns(bool) {
        if (_addr == msg.sender) {
            return true;
        }
        revert OwnerError(_addr);
    }

    function ChangeOwner (address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }
}
