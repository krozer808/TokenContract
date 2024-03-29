// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Token {
string public name = "Token";
string public symbol = "TKN";
uint256 public decimals = 18;
uint256 public totalSupply = 1000000 * (10**decimals); //1000000 * 10^18

// Track Balances
mapping(address => uint256) public balanceOf;
mapping(address => mapping(address => uint256)) public allowance;
// Send Tokens

event Transfer(
    address indexed from, 
    address indexed to, 
    uint256 value
    );

event Approval(
    address indexed owner, 
    address indexed spender, 
    uint256 value
    );

constructor(
    string memory _name, 
    string memory _symbol, 
    uint256 _totalSupply){
    name = _name;
    symbol = _symbol;
    totalSupply = _totalSupply;
    balanceOf[msg.sender] = totalSupply;
}
 function transfer(address _to, uint256 _value) 
    public 
    returns (bool success) 
    {
    require(balanceOf[msg.sender] >= _value, "Insufficient balance");
    
    _transfer(msg.sender, _to, _value);
    
    return true;
}

function _transfer(
    address _from,
    address _to,
    uint256 _value
) internal {
    require(_to != address(0));
    require(balanceOf[_from] >= _value, "Insufficient balance");

    // Check for overflow
    require(balanceOf[_to] + _value >= balanceOf[_to], "Overflow detected");

    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;

    emit Transfer(_from , _to, _value);
}
function approve(
    address _spender,
     uint256 _value)
public
returns(bool success)
{
    require(_spender != address(0));
    allowance[msg.sender][_spender] = _value;

    emit Approval(msg.sender, _spender, _value);
    return true;
}

function transferFrom(
    address _from, 
address _to, 
uint256 _value)
public
returns(bool success)
{
    //Check Approval
    require(_value <= balanceOf[_from], "Insufficient balance for transferFrom");
    require(_value <= allowance[_from][msg.sender], "Insufficient allowance for transferFrom");

    // Reset Allowance
    allowance[_from][msg.sender] -= _value;

    //Spend Tokens
    _transfer(_from, _to, _value);

    return true;
}
}