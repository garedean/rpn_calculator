#!/usr/bin/env ruby

require_relative 'lib/rpn_calculator'

class App
  def initialize(rpn_calculator: RpnCalculator.new)
    @rpn_calculator = rpn_calculator
  end

  def run
    print_directions

    loop do
      user_input = STDIN.gets.chomp

      puts @rpn_calculator.evaluate_char(user_input)
      exit if user_input == 'q'
    end
  end

  private

  def print_directions
    puts 'Welcome! This is a Reverse Polish Calculator. '\
         'Starting typing characters to begin evaluating '\
         'input.'
  end
end
