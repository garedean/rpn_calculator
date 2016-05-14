# frozen_string_literal: true
require_relative 'spec_helper'
require_relative '../lib/rpn_calculator'
require_relative '../lib/input'

describe RpnCalculator do
  describe '#evaluate_user_input' do
    def run_rpn_expression(rpn_expression)
      calculator = RpnCalculator.new

      rpn_expression.each do |v|
        calculator.evaluate_user_input(Input.new(v))
      end

      calculator.instance_variable_get(:@stack).last
    end

    context 'when evaluating invalid input' do
      it 'prints an error message' do
        invalid_inputs = %w(a A test & ^ % $ #)
        error  = "Something's wrong with that input, let's try again."
        logger = spy('Logger', error: error)

        calculator = RpnCalculator.new(logger: logger)

        invalid_inputs.each do |input|
          calculator.evaluate_user_input(Input.new(input))
        end
        expect(logger).to have_received(:error)
          .exactly(invalid_inputs.count).times
      end
    end

    context 'when evaluating a numeric value' do
      it 'adds the value to the stack' do
        rpn_expression = %w( 1 )
        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(1.0)
      end
    end

    context 'when evaluating an operator' do
      it 'calls #error on logger when the stack < 2 elements' do
        logger_spy = spy('Logger')
        allow(logger_spy).to receive(:error)

        input = Input.new('+')
        RpnCalculator.new(logger: logger_spy).evaluate_user_input(input)

        expect(logger_spy).to have_received(:error)
      end

      it 'adds two numbers' do
        rpn_expression = %w( 1 2 + )

        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(3.0)
      end

      it 'subtracts one number from another' do
        rpn_expression = %w( 5 10 - )

        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(-5.0)
      end

      it 'divides one number by another' do
        rpn_expression = %w( 12 4 / )

        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(3.0)
      end

      it 'multiplies two numbers' do
        rpn_expression = %w( 3 4 * )

        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(12.0)
      end

      it 'adds, subtracts, multiplies, and divides' do
        rpn_expression = %w( 6 4 5 + * 25 2 3 + / - )

        result = run_rpn_expression(rpn_expression)

        expect(result).to eq(49.0)
      end
    end
  end
end
