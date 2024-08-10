// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract LargestHolder {
    uint256[] balances;
    address[] holders;
    bool balancesSubmitted;
    uint256 txRequired;
    uint256 processStartIdx;
    uint256 processEndIdx;

    address largestHolder;
    uint256 currentLargestBalance;

    // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 3, 3, 4, 5, 5, 6, 7, 8, 8, 9, 98, 23]
    // ["0x00Ca3D317Df810e1A45EF31e6a490086cb46006B","0xeC4285608B1353dA27e67d444C2c06e10cCD0372","0xC97eeEA001A12C7dD07c9E70F2756881B1645648","0xec29f17A0e035e4B584ba10b0Ef51Aa1d434A68a",     "0xD23EE42603a46209D505CF4C96D9719C5f097bDF","0xB9Af978317e9B4691f40085931eA089b493FBd5D","0xa0d5e8dD93B3A637615Aae8365A1E59a34A39104","0x9Eda0966e97e39D9d49D711fA12781B7cF3a471c","0xc64e25C1B7944098508bD5f69C1D74DF61C6d818","0xf094B0193dC782771E59532b840D653d0aa0D356", "0xc18d7a35FF2460A59fe7050D97Ef5c1046CC4Bdf","0xE30ED7D6b9Fe76014E51E3C65838Ae2fC2077057","0xBf4C8cb212F704E633B71D1F451151567E92ED96","0x47cb6D7e3B7e5E00e7AD85ab9a19Ef97F4bA12Ec","0xebeAe807d6DC0480d904513d67E9c788eCbEd85B","0x706d417cEC231ab20A978D09b5Fa5599c8e146AA","0xDBD8B3f87524D4C7a2cB808f083a4D3a095c3c6d","0xD6a1055b9aD558E7EA3DCD2D7f755eaAaECa0c1E","0x198D4f4Dbc4e245FDA92fdAcca0F38C8C29dAC9F","0xCfCA8F7a279C27Bba27350Df256D75af10349cf3","0xAaB15Ef45cF4E6E77315129b835B2903671A741c","0xF83dB4aA607F58CA1ddae4a6B5a3d5392d6918Ff","0xDd28C4f8410a9A27B49D76c3821AB49CE90Abc54"]

    function submitBalances(
        uint256[] memory _balances,
        address[] memory _holders
    ) public {
        require(!balancesSubmitted, "Balances have already been submitted");
        balancesSubmitted = true;
        holders = _holders;
        balances = _balances;

        txRequired = holders.length / 10;
        if (txRequired * 10 < holders.length) {
            // need to handle remainder from division eg. 15/10 = 1 => 2 txRquired
            txRequired++;
        }

        processEndIdx = 10;
        if (processEndIdx > balances.length) {
            // make sure we do not iterate over values that do not exists
            processEndIdx = balances.length;
        }
    }

    function process() public {
        require(balancesSubmitted, "Balances not yet submitted");
        require(txRequired > 0, "Already processed the balances");

        for (uint256 i = processStartIdx; i < processEndIdx; i++) {
            uint256 possibleAmount = balances[i];
            if (currentLargestBalance < possibleAmount) {
                currentLargestBalance = possibleAmount;
                largestHolder = holders[i];
            }
        }

        processStartIdx = processEndIdx;
        processEndIdx += 10;

        if (processEndIdx > balances.length) processEndIdx = balances.length;
        txRequired--;
    }

    function numberOfTxRequired() public view returns (uint256) {
        require(balancesSubmitted, "Balances have not yet been submitted");
        return txRequired;
    }

    function getLargestHolder() public view returns (address) {
        require(txRequired == 0, "You have not finished processing");
        return largestHolder;
    }
}
