# frozen_string_literal: true
require 'rspec'
require 'byebug'
require 'simplecov'
SimpleCov.start

# Suppress console output while running rspec tests
RSpec.configure do |c|
  c.before { allow($stdout).to receive(:puts) }
end
