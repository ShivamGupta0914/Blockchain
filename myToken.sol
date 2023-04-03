//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IERC20.sol";

contract TokenImplement is IERC20 {
    error InSufficientAmount();
    uint256 internal tokenSupply = 1000;
    mapping(address => uint256) tokenBalance;
    mapping(address => mapping(address => uint256)) approvalBalance;
    address _owner;

    constructor() {
        _owner = msg.sender;
        tokenBalance[_owner] = tokenSupply * (10**18);
    }

    function totalSupply() external view returns (uint256) {
        return tokenSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return tokenBalance[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        if (tokenBalance[msg.sender] < amount) revert("Insuff");
        tokenBalance[msg.sender] -= amount;
        tokenBalance[to] = amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return approvalBalance[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        require(msg.sender != spender, "Can not approve Yourself");
        approvalBalance[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool) {
        require(from != to, "same from and to");
        require(
            tokenBalance[from] >= amount,
            "from does not have sufficient balance"
        );
        require(
            approvalBalance[from][msg.sender] >= amount,
            "Not Authorized Or Insufficient Balance"
        );
        approvalBalance[from][msg.sender] -= amount;
        tokenBalance[from] -= amount;
        tokenBalance[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function name() external pure returns (string memory) {
        return "SHIVA TOKEN";
    }

    function symbol() external pure returns (string memory) {
        return "SHIVA";
    }
}
