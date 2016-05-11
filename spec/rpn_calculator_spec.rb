require 'rspec'
require_relative '../lib/rpn_calculator'

describe RpnCalculator do
  it 'adds an operand to the stack' do
    calculator = RpnCalculator.new
    total = calculator.evaluate_char('2')

    expect(total).to eq(2.0)
  end
end
