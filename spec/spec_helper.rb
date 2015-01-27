require 'nokogiri'

require_relative '../lib/opener/language_identifier'
require_relative 'support/fixture_helpers'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.include FixtureHelpers
  config.extend FixtureHelpers
end
