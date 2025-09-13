pragma solidity >=0.6.2;

import './IYunaswapV2Router01.sol';

interface IYunaswapV2Router02 is IYunaswapV2Router01 {
   

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    
}
