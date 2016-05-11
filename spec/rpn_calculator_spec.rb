require_relative 'spec_helper'
require_relative '../lib/rpn_calculator'

describe RpnCalculator do
  describe '#evaluate_char' do
    it 'adds a value to the stack' do
      calculator = RpnCalculator.new
      total = calculator.evaluate_char('2')

      expect(calculator.running_total).to eq(2.0)
      expect(total).to eq(2.0)
    end
  end
end
