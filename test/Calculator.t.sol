// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

// Imports
import "forge-std/Test.sol";
import "../src/Calculator.sol";

// Contract Test
contract CalucalorTest is Test {
    // Objeto contrato + Variables constructor sc
    Calculator calculator;
    uint256 public initialResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    // Funcion setup()
    function setUp() public {
        calculator = new Calculator(initialResult, admin);
    }

    // Unit testing
    function testCheckInitialResult() public view {
        uint256 initialResult_ = calculator.result();
        assert((initialResult_ == initialResult));
    }

    function testAddition() public {
        uint256 num1_ = 2;
        uint256 num2_ = 3;

        uint256 resultado_ = calculator.addition(num1_, num2_);

        assert(resultado_ == num1_ + num2_);
    }

    function testSubtraction() public {
        uint256 num1_ = 4;
        uint256 num2_ = 2;

        uint256 result_ = calculator.subtraction(num1_, num2_);

        assert(result_ == num1_ - num2_);
    }

    function testMultiplication() public {
        uint256 num1_ = 5;
        uint256 num2_ = 4;

        uint256 resultado_ = calculator.multiplication(num1_, num2_);

        assert(resultado_ == num1_ * num2_);
    }

    function testCannotMultiplication2LargeNumbers() public {
        uint256 num1_ = 5;
        uint256 num2_ = type(uint256).max - 1;

        vm.expectRevert();
        calculator.multiplication(num1_, num2_);
    }

    function testDivision() public {
        uint256 num1_ = 5;
        uint256 num2_ = 2;

        vm.prank(admin);

        uint256 resultado_ = calculator.division(num1_, num2_);

        assert(resultado_ == num1_ / num2_);
    }

    function testIfNotAdminCallsDivisionReverts() public {
        vm.startPrank(randomUser);

        uint256 num1_ = 5;
        uint256 num2_ = 2;

        vm.expectRevert();
        calculator.division(num1_, num2_);

        vm.stopPrank();
    }

    function testAdminCanCallDivisionCorrrectly() public {
        vm.startPrank(admin);

        uint256 num1_ = 5;
        uint256 num2_ = 2;

        calculator.division(num1_, num2_);

        vm.stopPrank();
    }

    function testDefaultCannotCallDivisionCorrrectly() public {
        uint256 num1_ = 5;
        uint256 num2_ = 2;

        console.log(msg.sender);
        vm.expectRevert();
        calculator.division(num1_, num2_);
    }

    function testDefaultExecuteDivisionCorrrectly() public {
        vm.startPrank(admin);

        uint256 num1_ = 5;
        uint256 num2_ = 2;

        uint256 result_ = calculator.division(num1_, num2_);
        assert(result_ == num1_ / num2_);

        vm.stopPrank();
    }

    function testCannotDividedByZero() public {
        vm.startPrank(admin);

        uint256 num1_ = 5;
        uint256 num2_ = 0;

        vm.expectRevert();
        calculator.division(num1_, num2_);

        vm.stopPrank();
    }

    // Fuzzing testing
    function testFuzzingDivision(uint256 num1_, uint256 num2_) public {
        vm.assume(num2_ != 0);

        vm.startPrank(admin);

        calculator.division(num1_, num2_);

        vm.stopPrank();
    }
}
