# Text file provider main class
#
# @since 0.0.1

class DomainOwnershipChecker
  class Providers
    # TextFileProvider class
    #
    # @since 0.0.1
    class TextFileProvider < BaseProvider
      attr_reader :filename

      require 'openssl'
      OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

      def initialize(options)
        super(options)
        validate_options!(options)
      end

      def verified?
        fetch('http://' + domain + '/' + filename) == 200
      end

      private

      def validate_options!(options)
        @filename = begin
                  options.fetch(:filename)
                rescue
                  raise ArgumentError, 'Options should be included :filename'
                end
      end

      def fetch(location, limit = 10)
        require 'net/http'

        uri = URI(location)
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new uri
          response = http.request(request)

          case response
          when Net::HTTPMovedPermanently
            location = response['location']
            fetch(location, limit - 1)
          else
            response.code.to_i
          end
        end
      end
    end
  end
end
