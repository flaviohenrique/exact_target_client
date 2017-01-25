module ExactTargetClient
  class Client
    API_URL = 'https://www.exacttargetapis.com/hub/v1/dataevents/key:%s/rowset'.freeze

    def initialize(authentication = ExactTargetClient::Authentication.new, http = ExactTargetClient::HTTP.new)
      @authentication = authentication
      @http = http
    end

    def post(params)
      tries = 0
      begin
        token = ExactTargetClient.cache.get('exact_target_api_token')
        @http.post(API_URL % params[:key], params[:data], 'Authorization' => "Bearer #{token}")
      rescue => e
        tries = tries.next

        retry if tries <= 2 && unauthorized(e) && renew_token
        raise e
      end
    end

    def unauthorized(e)
      e.respond_to?(:http_code) && e.http_code == 401
    end

    def authenticate
      @authentication.token
    end

    def renew_token
      ExactTargetClient.cache.set('exact_target_api_token', authenticate)
    end
  end
end
