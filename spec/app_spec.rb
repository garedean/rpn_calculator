require 'spec_helper'
require 'stringio'
require_relative '../app'

describe App do
  describe '#run' do
    before(:each) do
      rpn_calculator = double('Calculator', evaluate_char: '1')

      @app = App.new(rpn_calculator: rpn_calculator, logger: nil)
    end

    before do
      @io_object = double('IO Object')
      expect(@app).to receive(:gets).and_return(@io_object)
    end

    it 'should display output from rpn_calculator' do
      expect(@io_object).to receive(:chomp).and_return('1')

      rpn_calculator = double('Calculator', evaluate_char: '1')

      expect { @app.run }.to output("1\n").to_stdout
    end
  end
end
