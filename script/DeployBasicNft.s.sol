// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNft.sol";

contract DeployBasicNft is Script {
    function run() external returns (BasicNFT) {
        vm.startBroadcast();
        BasicNFT basicNft = new BasicNFT();
        vm.stopBroadcast();
        return basicNft;
    }
}
