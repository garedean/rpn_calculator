# frozen_string_literal: true
require 'spec_helper'
require 'stringio'
require_relative '../app'

describe App do
  describe '#run' do
    def build_app(simulate_user_input_with:)
      rpn_calculator = double(
        'Calculator', evaluate_char: simulate_user_input_with
      )

      App.new(rpn_calculator: rpn_calculator, logger: nil)
    end

    let(:io_object) do
      double('IO Object')
    end

    it 'should display output from rpn_calculator' do
      app = build_app(simulate_user_input_with: '1')
      expect(app).to receive(:gets).and_return(io_object)
      expect(io_object).to receive(:chomp).and_return('1')

      expect { app.run }.to output("1\n").to_stdout
    end

    it "should exit the program if 'q' is received" do
      app = build_app(simulate_user_input_with: 'q')
      expect(app).to receive(:gets).and_return(io_object)
      expect(io_object).to receive(:chomp).and_return('q')

      expect { app.run }.to raise_error(SystemExit)
    end
  end
end
