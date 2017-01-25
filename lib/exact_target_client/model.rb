module ExactTargetClient
  class Model
    def initialize(client = ExactTargetClient::Client.new)
      @client = client
    end

    def save(table_name, data, valid_data = true)
      data = build_data(data, valid_data)
      
      key = config.table_ids.to_h[table_name.to_sym]

      @client.post(key: key, data: data)
    end

    def build_data(data, valid_data)
      data[:values][:valid] = valid_data
      [data]
    end

    def config
      ExactTargetClient.config
    end
  end
end
