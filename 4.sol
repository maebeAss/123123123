contract Character {
    string username;
    uint lastPaymentDate;
    uint lastPaymentAmount;
    address owner;
    uint public health = 10;
    constructo(string memory nameIn) payable {
        owner = payable(msg.sender);
        username = nameIn;
        // lastPaymentDate = block.timestamp;
        // lastPaymentAmount = (msg.value);
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    struct Payment {
        uint lastPaymentAmount;
        uint lastPaymentDate;
    }

    struct CharacterData {
        uint balance;
        uint health;
        string username;
        mapping(uint => Payment) payments;
    }

    mapping (address => CharacterData) CharactererData;

    function getPayment (address _addr, uint _uint) public view returns (Payment memory) {
        return CharactererData[_addr].payments[_uint];
    }

    function deposit() public payable {
        uint paymentNum = CharactererData[msg.sender].balance;
        require(msg.value >= 0.01 ether, "Minimum payment required is 0.01 ETH");
        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp
        );

        CharactererData[msg.sender].payments[paymentNum] = newPayment;
    }

    uint public healthCheck = CharactererData[msg.sender].health;
    error MinPayment (uint MinPay);
    
    function increaseHealth () public onlyOwner payable returns (uint _health) {
        // require(address(this).balance >= 0.001 ether, "Minimum payment for increasing health required is 0.01 ETH");
        if (address(this).balance >= 0.001 ether) {
            address(this).balance - 0.001 ether;
            return _health;
        }
        revert MinPayment (address(this).balance);
    }
}
