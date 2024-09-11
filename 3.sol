pragma solidity >=0.8.2 <0.9.0;

contract base {
    address public owner;
    constructor () payable {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function ChangeOwner(address _owner) public onlyOwner {
        owner = _owner;
    }
    function gameReward(uint _i) external virtual returns (uint) {
        return _i;
    }
    function gameLose(uint _i) external virtual returns (uint) {
        return _i;
    }
}

abstract contract base0 is base {
    function gameLose () internal view virtual returns (uint) {
        return 4;
    }
}

contract base1 is base0 {
    constructor(address _owner) payable {
        owner = payable(_owner);
    }
    
    function gameLose (uint _i) public view override onlyOwner returns(uint) {
        _i = _i * 10;
        return _i;
    }

    function gameReward (uint _i) public view override onlyOwner returns(uint) {
        _i = 1 * _i;
        return _i;
    }

    function getBalance () public payable {
        
    }
}
