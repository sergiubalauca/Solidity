// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// ============== INSTANTIATING CONTRACTS ==============
contract Storage0 {
    uint256 public x;

    function setX(uint256 newX) public {
        x = newX;
    }
}

contract Caller0 {
    Storage0 store;
    Storage0 store2; // If I initialise a second store, it's going to have its own state, so different values per instance

    constructor() {
        store = new Storage0();
    }

    function setX(uint256 x) public {
        store.setX(x);
    }

    function getX() public view returns (uint256) {
        return store.x(); // I need to set up paranthesis, because behind the curtains it creates a getter for my var
    }
}

// ============== INHERITANCE ==============
contract Storage {
    uint256 internal x;

    constructor(uint256 startingValue) {
        x = startingValue;
    }

    function setX(uint256 newX) public {
        x = newX;
    }

    function getX() public view virtual returns (uint256) {
        // when overriding a function, I need to mark the child one with virtual
        return x + 10;
    }
}

contract Child is Storage {
    constructor(uint256 startingValue) Storage(startingValue) {
        // when we expect a initial value in constructor of base, I can define it like this,
        // or I can do something like contract Child is Storage(4)
    }

    function getX() public view override returns (uint256) {
        // when overriding a function, I need to mark the child one with override
        // return x;
        // If I do something like return getX(), then there will be a misleading situation - same signature in both base and child contract
        // It's actually going to call getX from this child contract. Therefore I need to use super();
        return super.getX();
    }

    function getX(uint256 add) public view returns (uint256) {
        // when overloading a function, I DON'T need to mark the child one with override
        return x + add;
    }
}

// ============== MULTIPLE INHERITANCE ==============
contract A {
    uint256 x;

    function setX(uint256 newX) public virtual {
        x = newX;
    }

    function getX() public view virtual returns (uint256) {
        return 1;
    }
}

contract B {
    uint256 y;

    function setX(uint256 newY) public virtual {
        y = newY;
    }

    function getX() public view virtual returns (uint256) {
        return 2;
    }
}

contract Kid is
    A,
    B // FUNCTION RESOLUTION ORDER - the order defined here sais which functions are called in the end
{
    // if we have the same signatures in parents
    function getX() public view override(A, B) returns (uint256) {
        return super.getX();
    }

    function setX(uint256 newX) public override(A, B) {
        super.setX(newX);
    }

    // function test() public view returns (uint256) {
    //     return super.getY() + super.getX();
    // }
}

// ============== INHERITANCE EXAMPLE ==============
enum Type {
    OnePercent,
    TwoPercent
}

enum Size {
    Small,
    Medium,
    Large
}

contract Item {
    uint256 price;

    constructor(uint256 _price) {
        price = _price;
    }

    function getPrice() public view returns (uint256) {
        return price;
    }
}

contract Milk is Item(5) {
    Type milkType;
    uint256 litres;

    constructor(Type _milkType, uint256 _litres) {
        milkType = _milkType;
        litres = _litres;
    }
}

contract Shirt is Item(10) {
    Size size;

    constructor(Size _size) {
        size = _size;
    }
}

contract ShoppingList {
    Item[] items;

    function addMilk(Type _type, uint256 litres) public {
        Milk milk = new Milk(_type, litres);
        items.push(milk);
    }

    function addShirt(Size size) public {
        Shirt shirt = new Shirt(size);
        items.push(shirt);
    }

    function getTotalPrice() public view returns (uint256) {
        uint256 price;

        for (uint256 idx; idx < items.length; idx++) {
            price += items[idx].getPrice();
        }

        return price;
    }
}
