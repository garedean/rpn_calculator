# frozen_string_literal: true
require 'logger'

# Calculates the running total for a Reverse Polish Notation stream of input
class RpnCalculator
  attr_reader :stack, :logger

  def initialize(logger: Logger.new($stdout))
    @stack  = []
    @logger = logger
  end

  def evaluate_user_input(user_input)
    if user_input.numeric?
      add_value_to_stack(user_input)
    elsif user_input.operator?
      evaluate_operator(user_input)
    else
      logger.error "Something's wrong with that input, let's try again."
    end
  end

  private

  def add_value_to_stack(user_input)
    stack.push(user_input.parsed_value)

    print_last_evaluated_statement
  end

  def evaluate_operator(user_input)
    if operation_valid?
      perform_calculation(user_input)

      print_last_evaluated_statement
    else
      logger.error "Oh no! Using a '#{user_input.parsed_value}' here "\
                   "doesn't form a valid RPN equation. It's cool, we'll "\
                   'keep it between us...'
    end
  end

  def perform_calculation(user_input)
    later_val   = stack.pop
    earlier_val = stack.pop

    stack << case user_input.parsed_value
             when '+' then earlier_val + later_val
             when '-' then earlier_val - later_val
             when '/' then earlier_val / later_val
             when '*' then earlier_val * later_val
             end
  end

  def operation_valid?
    stack.count >= 2
  end

  def print_last_evaluated_statement
    puts pretty_print_float(stack.last)
  end

  def pretty_print_float(float)
    sprintf('%g', float)
  end
end
