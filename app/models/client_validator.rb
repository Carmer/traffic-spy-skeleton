module TrafficSpy
  class ClientValidator < Client

    def self.validate(data)
      info = ClientParser.parse(data)
      client = Client.new(info)
      if client.save 
        json_body = JSON.generate({"identifier"=>client.identifier})
        {code: 200, message: json_body}
      elsif Client.find_by(identifier: client.identifier)
        errors = client.errors.full_messages
        {code: 403, message: errors}
      else
        errors = client.errors.full_messages
        {code: 400, message: errors}
      end

    end

  end
end
