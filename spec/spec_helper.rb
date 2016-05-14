# frozen_string_literal: true
require 'rspec'
require 'byebug'
require 'simplecov'
SimpleCov.start

# Suppress console output while runing rspec tests
RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end
