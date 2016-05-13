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
    case
    when numeric?(char)
      add_value_to_stack(char)
    when operator?(char)
      evaluate_operator(char)
    else
      logger.error "Something's wrong with that input, let's try again."
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
      logger.error "Oh no! Using a '#{char}' right now isn't a valid "\
                   "RPN equation. It's cool, we'll keep it between us..."
    end
  end

  def operation_valid?
    stack.count >= 2
  end

  def numeric?(string)
    true if Float(string) rescue false
  end

  def operator?(string)
    string =~ %r{^[+\-*/]$}
  end
end
