require_relative 'spec_helper'
require_relative '../lib/rpn_calculator'

describe RpnCalculator do
  describe '#evaluate_char' do
    it 'adds a value to the stack' do
      calculator = RpnCalculator.new
      total = calculator.evaluate_char('1')

      expect(total).to eq(1.0)
    end

    context 'when evaluating an operator' do
      it 'prints an error mesage when the stack < 2 elements' do
        error = 'Invalid character, try again!'
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

        total = calculator.evaluate_char('+')

        expect(total).to eq(3.0)
      end

      it 'subtracts one number from another' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('5')
        calculator.evaluate_char('1')

        total = calculator.evaluate_char('-')

        expect(total).to eq(4.0)
      end

      it 'divides one number by another' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('12')
        calculator.evaluate_char('4')

        total = calculator.evaluate_char('/')

        expect(total).to eq(3.0)
      end

      it 'multiplies two numbers' do
        calculator = RpnCalculator.new

        calculator.evaluate_char('3')
        calculator.evaluate_char('4')

        total = calculator.evaluate_char('*')

        expect(total).to eq(12.0)
      end
    end
  end
end
