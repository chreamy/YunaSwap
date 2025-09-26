pragma solidity >=0.6.2;

import './IYunaswapRouter01.sol';

interface IYunaswapRouter02 is IYunaswapRouter01 {
   

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    
}
