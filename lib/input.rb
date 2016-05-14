# frozen_string_literal: true

# Represents the values and operators the user enters into the terminal
# to interact with the program
class Input
  def initialize(terminal_input)
    @terminal_input = parse_input(terminal_input)
  end

  def numeric?
    @terminal_input.is_a?(Float)
  end

  def operator?
    (@terminal_input =~ %r{^[+\-*/]$}) ? true : false
  end

  def parsed_value
    @terminal_input
  end

  private

  # If user input arrives as an Integer/Float (but as a string),
  # convert it to a Float
  def parse_input(terminal_input)
    if float?(terminal_input)
      terminal_input.to_f
    else
      terminal_input
    end
  end

  def float?(terminal_input)
    true if Float(terminal_input)
  rescue
    false
  end
end
