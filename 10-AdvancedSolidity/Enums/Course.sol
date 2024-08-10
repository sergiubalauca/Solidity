// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Enums {
    enum Status {
        // enum is actually an uint8 value
        Pending, // 0
        Shipped, // 1
        Delivered // 2
    }

    Status public status; // equals by default to 0

    function setStatus(Status val) public {
        status = val;
    }

    function setStatusShipped() public {
        status = Status.Shipped;
    }

    function isDelivered() public view returns (bool) {
        return status == Status.Delivered;
    }

    function isShipped() public view returns (bool) {
        return status == Status.Shipped;
    }

    function resetEnum() public {
        delete status;
    }
}
