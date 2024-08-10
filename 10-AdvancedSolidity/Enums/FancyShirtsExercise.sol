// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract FancyShirts {
    enum Size {
        Small,
        Medium,
        Large
    }

    enum Color {
        Red,
        Green,
        Blue
    }

    mapping(address => UserShirt) userShirts;

    struct UserShirt {
        string userName;
        Shirt[] shirts;
    }

    struct Shirt {
        Size size;
        Color color;
    }

    mapping(Size => uint256) sizePrice;
    mapping(Color => uint256) colorPrice;

    constructor() {
        sizePrice[Size.Small] = 10 wei;
        sizePrice[Size.Medium] = 15 wei;
        sizePrice[Size.Large] = 20 wei;

        colorPrice[Color.Red] = 0 wei;
        colorPrice[Color.Green] = 5 wei;
        colorPrice[Color.Blue] = 5 wei;
    }

    function getShirtPrice(Size size, Color color)
        public
        view
        returns (uint256)
    {
        return sizePrice[size] + colorPrice[color];
    }

    function buyShirt(Size size, Color color) public payable {
        require(
            msg.value == getShirtPrice(size, color),
            "You didn't provide the exact amount required"
        );

        Shirt memory shirt = Shirt({size: size, color: color});

        userShirts[msg.sender].shirts.push(shirt);
    }

    function getShirts(Size size, Color color) public view returns (uint256) {
        uint256 count;

        Shirt[] memory userS = userShirts[msg.sender].shirts;

        for (uint256 idx; idx < userS.length; idx++) {
            if (userS[idx].size == size && userS[idx].color == color) {
                count++;
            }
        }

        return count;
    }
}
