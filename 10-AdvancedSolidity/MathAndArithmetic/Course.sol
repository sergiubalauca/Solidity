// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract MathAndArithmetic {
    // Pay special attention to the pragma line. It states that the compiler version is between 0.7.0 and 0.7.6. This means that Solidity will not handle overflows and underflows by default, meaning the contract will
    // not revert and instead use integer wrapping, resulting in a return value of 244.
    // Note: in this situation an underflow occurred as the computed value was too small to fit in the uint8 type.

    using SafeMath for uint;
    uint p = x = 2.99929e10;

    function testOverFlowUnderflow(uint8 x, uint8 y)
        public
        pure
        returns (uint8)
    {
        assert(y <= x);
        return x + y;
    }

    function testSafeMath(uint8 x, uint8 y) public pure returns (uint256) {
        return SafeMath.mod(x, y);
    }
}
