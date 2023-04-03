//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "./IERC20.sol";
contract Minter{

    IERC20 internal shivaToken;
    uint256 internal decimalCount;
    constructor(address _tokenAddress){
        shivaToken = IERC20(_tokenAddress);
    }

    function sendTokenFrom(address _fromAddress) external{
       uint256 balance = shivaToken.balanceOf(_fromAddress);
       uint256 amountToBeTransfer = (((balance)*(3))/(100));
       if(amountToBeTransfer != 0){
         shivaToken.transferFrom(_fromAddress, msg.sender, amountToBeTransfer);
       }else{
           revert("can not transfer token anymore");
       }
       
    }
    function balanceOfShivaToken() external view returns(uint){

        return shivaToken.balanceOf(msg.sender);
    }

}
