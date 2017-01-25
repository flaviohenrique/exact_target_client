require 'restclient'

module ExactTargetClient
  class HTTP
    def default_headers
      { content_type: :json, accept: :json }
    end

    def post(url, params = {}, headers = {})
      ::RestClient.post(url, params.to_json, default_headers.merge(headers))
    end
  end
end
