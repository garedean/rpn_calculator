#!/usr/bin/env ruby

require 'logger'
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
    1.times do
      user_input = gets.chomp
      exit if user_input == 'q'

      puts @rpn_calculator.evaluate_char(user_input)
    end
  end

  private

  def print_directions
    puts 'Welcome! This is a Reverse Polish Calculator. '\
         'Starting typing characters to begin evaluating '\
         'input.'
  end
end
