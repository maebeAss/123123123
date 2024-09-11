// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract MyContract {

    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping (address => Balance) public balances;

    function getPayment (address _addr, uint _uint) public view returns (Payment memory) {
        return balances[_addr].payments[_uint];
    }

    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;

    }

    function check (string memory _str) public pure returns (uint) {
        if(keccak256(bytes(_str))==keccak256(bytes("hell"))) {
            return 1;
        }
        return 0;
    }   // uint256 public NumberPlus = 100;
    // function TestMemory () public {
    //     NumberPlus = NumberPlus / 2;
    // }
    // function testStorage () public {
    //     NumberPlus = NumberPlus + 2;
    // }
}
