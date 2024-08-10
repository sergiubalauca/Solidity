// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// === Storage ===
/*
    - permanent, stored in blockchain, expensive to write to, free to read from
    - containrs 2^256 slots
    - each storage slot can hold 32 bytes
    - storage slots can store multiple values/variables - meaning we can pack multiple variables if small enough
*/

// === Memory ===
/*
    - temprary location
    - stored in RAM
    - cheaper to write to
    - mutable
    - typically used for reference types (because there is not enough room in stack)
    - cleared after function execution
    - memory -> memory => reference
    - storage -> storage => reference
    - memory -> storage => copy
    - storage -> memory => copy
*/

// === Call Data ===
/*
    - temporary location
    - only stores function arguments
    - can be cheaper than memory
    - immutable
    - useful for insuring no unintended copies are made
*/

// === Stack ===
/*
    - temporary location
    - internal location, not directly accesible (requires assembly)
    - used for small local variables
    - stores values needed for immediate processing
    - stores function value types (uint, int, string, etc)
    - can hold up to 1024 values
*/

// === Logs ===
/*
    - associated with transactions
    - cannot be accesed by smart contracts
    - where event data is stored
    - cheap data structure
    - accesed off the blockchain
*/

// === Code ===
/*
    - code itself is stored ( so it can just be considered as storage type)
    - constant variables stored here
*/
