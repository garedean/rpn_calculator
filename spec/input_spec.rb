# frozen_string_literal: true
require 'spec_helper'
require_relative '../lib/rpn_calculator'
require_relative '../lib/input'

describe Input do
  describe '#numeric?' do
    it 'returns true if numeric' do
      expect(Input.new('5').numeric?).to eq true
    end

    it 'returns false if not numeric' do
      expect(Input.new('a').numeric?).to eq false
    end
  end

  describe '#operator?' do
    it 'returns true if operator' do
      expect(Input.new('+').operator?).to eq true
    end

    it 'returns false if not operator' do
      expect(Input.new('a').operator?).to eq false
    end
  end

  describe '#parsed_value' do
    it 'returns a float' do
      expect(Input.new('5').parsed_value).to eq(5.0)
    end

    it 'returns an operator' do
      expect(Input.new('+').parsed_value).to eq('+')
    end
  end
end
