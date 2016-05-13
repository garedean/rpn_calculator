require_relative 'spec_helper'
require_relative '../lib/rpn_calculator'

describe RpnCalculator do
  describe '#evaluate_char' do
    context 'when evaluating invalid input' do
      it 'prints an error message' do
        invalid_inputs = %w(a A test & ^ % $ #)
        error  = "Something's wrong with that input, let's try again."
        logger = spy('Logger', error: error)

        calculator = RpnCalculator.new(logger: logger)

        invalid_inputs.each do |input|
          calculator.evaluate_char(input)
        end
        expect(logger).to have_received(:error)
          .exactly(invalid_inputs.count).times
      end
    end

    context 'when evaluating a numeric value' do
      it 'adds the value to the stack' do
        calculator = RpnCalculator.new
        result = calculator.evaluate_char('1')

        expect(result).to eq(1.0)
      end
    end

    context 'when evaluating an operator' do
      it 'prints an error mesage when the stack < 2 elements' do
        error = "Oh no! Using a '+' here doesn't form a valid RPN "\
                "equation. It's cool, we'll keep it between us..."

        logger = spy('Logger', error: error)
        calculator = RpnCalculator.new(logger: logger)

        calculator.evaluate_char('1')
        calculator.evaluate_char('+')

        expect(logger).to have_received(:error).with(error)
      end

      it 'adds two numbers' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('1')
        calculator.evaluate_char('2')

        result = calculator.evaluate_char('+')

        expect(result).to eq(3.0)
      end

      it 'subtracts one number from another' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('5')
        calculator.evaluate_char('1')

        result = calculator.evaluate_char('-')

        expect(result).to eq(4.0)
      end

      it 'divides one number by another' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('12')
        calculator.evaluate_char('4')

        result = calculator.evaluate_char('/')

        expect(result).to eq(3.0)
      end

      it 'multiplies two numbers' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('3')
        calculator.evaluate_char('4')

        result = calculator.evaluate_char('*')

        expect(result).to eq(12.0)
      end

      it 'adds, subtracts, multiplies, and divides' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('6')
        calculator.evaluate_char('4')
        calculator.evaluate_char('5')
        calculator.evaluate_char('+')
        calculator.evaluate_char('*')
        calculator.evaluate_char('25')
        calculator.evaluate_char('2')
        calculator.evaluate_char('3')
        calculator.evaluate_char('+')
        calculator.evaluate_char('/')
        result = calculator.evaluate_char('-')

        expect(result).to eq(49.0)
      end
    end
  end
end
