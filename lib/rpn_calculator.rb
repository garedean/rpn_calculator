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
    when /[+]/
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
      case char
      when '+'
        stack << (stack.pop + stack.pop)
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
