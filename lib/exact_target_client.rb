require_relative 'exact_target_client/version'
require_relative 'exact_target_client/http'
require_relative 'exact_target_client/authentication'
require_relative 'exact_target_client/client'
require_relative 'exact_target_client/model'

require 'configurations'

module ExactTargetClient
  include ::Configurations

  module_function

  def cache=(cache)
    @cache = cache
  end

  def cache
    @cache
  end

  def config
    configuration
  end
end
