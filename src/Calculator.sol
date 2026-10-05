// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract Calculator {
  // Variables
  uint256 public result;
  address public admin;

  // Modifiers
  modifier onlyAdmin {
    require(msg.sender == admin, "Not allowed");
    _;
  }

  // Events
  event AdditionEvent(uint256 num1, uint256 num2, uint256 result);
  event SubtractionEvent(uint256 num1, uint256 num2, uint256 result);
  event MultiplicationEvent(uint256 num1, uint256 num2, uint256 result);
  event DivisionEvent(uint256 num1, uint256 num2, uint256 result);

  constructor(uint256 initialResult_, address admin_) {
    result = initialResult_;
    admin = admin_;
  }

  // Functions
  function addition(uint256 num1_, uint256 num2_) external returns(uint256 result_) {
    result_ = num1_ + num2_;
    result = result_;

    emit AdditionEvent(num1_, num2_, result_);
  }

  function subtraction(uint256 num1_, uint256 num2_) external returns(uint256 result_) {
    require(num2_ <= num1_, "Result cannot be negative");
    result_ = num1_ - num2_;
    result = result_;

    emit SubtractionEvent(num1_, num2_, result_);
  }

  function multiplication(uint256 num1_, uint256 num2_) external returns(uint256 result_) {
    result_ = num1_ * num2_;
    result = result_;

    emit MultiplicationEvent(num1_, num2_, result_);
  }

  function division(uint256 num1_, uint256 num2_) external onlyAdmin() returns(uint256 result_) {
    require(num2_ != 0, "Division by zero error");
    // if (num2_ == 0) return 0;
    result_ = num1_ / num2_;
    result = result_;

    emit DivisionEvent(num1_, num2_, result_);
  }
}