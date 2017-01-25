module ExactTargetClient
  class Authentication
    AUTH_URL = 'https://auth.exacttargetapis.com/v1/requestToken'.freeze

    def initialize(http = ExactTargetClient::HTTP.new)
      @http = http
    end

    def token
      content = { clientId: config.client_id,
                  clientSecret: config.client_secret }

      response = @http.post(AUTH_URL, content)

      JSON.parse(response)['accessToken']
    end

    def config
      ExactTargetClient.config
    end
  end
end
