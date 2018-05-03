# spec/support/factory_bot.rb

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end