$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'rspec'
require 'simplecov'
require 'exact_target_client'
require 'yaml'
require 'webmock/rspec'
require 'pry'
require 'redis'

file = File.join(File.dirname(__FILE__), "/config.yml")

yaml_hash = YAML.load_file(file)

ExactTargetClient.cache = Redis.new

ExactTargetClient.configure do |c|
  c.from_h(yaml_hash)
end

SimpleCov.start do
  add_group 'lib', 'lib'
end
