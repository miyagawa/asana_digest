require 'net/https'
require 'uri'
require 'json'

module AsanaDigest
  class Client
    def initialize(apikey)
      @apikey = apikey
    end

    def get(path, options={})
      uri = URI.parse("https://app.asana.com/api/1.0#{path}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(@apikey, '')
      response = http.request(request)

      JSON.load(response.body)['data']
    end
  end
end

