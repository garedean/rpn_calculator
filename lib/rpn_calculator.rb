class RpnCalculator
  attr_reader :stack

  def initialize
    @stack = []
  end

  def evaluate_char(char)
    case char
    when '+'
    when '-'
    when '*'
    when '/'
    else
      add_to_stack(char)
    end

    stack.first
  end

  private

  def add_to_stack(char)
    stack.push(char.to_f)
  end
end
