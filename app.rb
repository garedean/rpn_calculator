# frozen_string_literal: true

require 'logger'
require_relative 'lib/input'
require_relative 'lib/rpn_calculator'

# Accepts user input via 'gets', interracts with RpnCalculator class
class App
  def self.build
    logger = Logger.new($stdout)
    rpn_calculator = RpnCalculator.new(logger: logger)

    new(rpn_calculator: rpn_calculator, logger: logger)
  end

  attr_reader :logger

  def initialize(rpn_calculator:, logger:)
    @rpn_calculator = rpn_calculator
    @logger = logger

    print_directions
  end

  def run
    loop do
      user_input = Input.new(capture_user_input)
      exit if user_input.parsed_value == 'q'

      @rpn_calculator.evaluate_user_input(user_input)
    end
  end

  private

  def print_directions
    puts "Welcome! This is a Reverse Polish (RPN) Calculator. "\
         "Enter each element of an RPN expression one by one, " \
         "followed by hitting the 'Enter' key. Valid inputs are "\
         "any positive or negative number, including decimals, or "\
         "the following operators: '+', '-', '*', '/'. Here's an "\
         "example RPN expression to get you started: 1 2 3 4 5 + × - /"
  end

  def capture_user_input
    $stdin.gets.chomp
  end
end
