pragma solidity >=0.6.6;

import '../YunaswapERC20.sol';

contract ERC20 is YunaswapERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
