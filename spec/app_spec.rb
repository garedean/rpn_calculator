# frozen_string_literal: true
require 'spec_helper'
require 'stringio'
require_relative '../app'

describe App do
  describe '#run' do
    def build_app(simulate_user_input_with:)
      @rpn_calculator = double(
        'Calculator', evaluate_user_input: simulate_user_input_with
      )

      App.new(rpn_calculator: @rpn_calculator, logger: nil)
    end

    it 'receives and evaluates user input' do
      user_input = '1'
      input_dbl = instance_double('Input', parsed_value: 1)

      allow($stdin).to receive_message_chain('gets.chomp')
        .and_return(user_input)

      allow(Input).to receive(:new).and_return(input_dbl)

      app = build_app(simulate_user_input_with: user_input)
      allow(app).to receive(:loop).and_yield

      app.run

      expect(@rpn_calculator).to have_received(:evaluate_user_input)
        .with(input_dbl)

      expect(Input).to have_received(:new)
        .with(user_input)
    end

    it "should exit the program if 'q' is received" do
      user_input = 'q'

      app = build_app(simulate_user_input_with: user_input)

      allow($stdin).to receive_message_chain('gets.chomp')
        .and_return(user_input)

      allow(Input).to receive_message_chain('new.parsed_value').and_return('q')

      expect { app.run }.to raise_error(SystemExit)
    end
  end
end
