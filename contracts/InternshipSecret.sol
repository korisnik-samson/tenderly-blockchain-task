/**
 *Submitted for verification at Etherscan.io on 2025-03-14
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.16 <0.9.0;

interface Vault {
    function key() external returns(string memory);
    function secret() external returns(string memory);
}

contract InternshipSecret {
    Vault private vault = Vault(address(0x0000000000000000000000000000000000000000));
    address private owner;
    bool private inited;

    constructor() {
        owner = msg.sender;
        inited = false;
    }

    function init(address v) public {
        require(msg.sender == owner, "Not Owner!");
        require(!inited, "Already inited!");
        inited = true;
        vault = Vault(v);
    }

    function shareKey() public payable returns(string memory) {
        require(msg.sender == address(0xffEEFfEeffEEFfeeFFEeFFeeFfEefFeeFFeEFfee), "Bad Sender");
        return vault.key();
    }

    function shareSecret(string calldata _key) public payable returns(string memory) {
        require(msg.sender == address(0xffEEFfEeffEEFfeeFFEeFFeeFfEefFeeFFeEFfee), "Bad Sender");
        require(keccak256(bytes(_key)) == keccak256(bytes(vault.key())), "Wrong Key Entered");
        return vault.secret();
    }

}