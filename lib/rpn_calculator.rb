require 'logger'
require 'byebug'

# Calculates the running total for a Reverse Polish Notation stream of input
class RpnCalculator
  attr_reader :stack, :logger

  def initialize(logger: Logger.new($stdout))
    @stack  = []
    @logger = logger
  end

  def evaluate_char(char)
    case char
    when %r{[*+-\/]}
      evaluate_operator(char)
    else
      add_value_to_stack(char)
    end

    stack.last
  end

  private

  def add_value_to_stack(char)
    stack.push(char.to_f)
  end

  def evaluate_operator(char)
    if operation_valid?
      later_val   = stack.pop
      earlier_val = stack.pop

      stack << case char
               when '+' then earlier_val + later_val
               when '-' then earlier_val - later_val
               when '/' then earlier_val / later_val
               when '*' then earlier_val * later_val
               end
    else
      logger.error 'Invalid character, try again!'
      return nil
    end

    stack.last
  end

  def operation_valid?
    stack.count >= 2
  end
end
