require "addressable/uri"

module Myapp
  module Helper
    module Fetcher

      private
      def fetch url
        uri = Addressable::URI.parse url
        response = fetch_all uri

        if response == nil
          response = fetch_head uri
          limit = 1
        end
        response
      end

      def fetch_head uri
        request = Net::HTTP.new uri.host
        request.head uri.request_uri
      end

      def fetch_all uri
        http = Net::HTTP.new uri.host, uri.port
        req = Net::HTTP::Get.new uri.request_uri
        res = http.request req
        if res.is_a? Net::HTTPSuccess
          res.uri = uri.to_s
          res["charset"] = res.header["content-type"].rpartition("charset=").last.strip.downcase
        end
        res
      end
    end
  end
end
