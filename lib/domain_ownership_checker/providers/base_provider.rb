# Base provider main class
#
# @since 0.0.1

require 'socket'

class DomainOwnershipChecker
  class Providers
    # Base provider main class
    #
    # @since 0.0.1
    class BaseProvider
      attr_reader :domain

      def initialize(options)
        raise ArgumentError, 'Options should be provided' unless options

        @domain = begin
                    options.fetch(:domain)
                  rescue
                    raise ArgumentError, 'Options must contain :domain'
                  end

        # Validations
        domain_exists?
      end

      def domain_exists?
        Socket.gethostbyname(domain)
        true
      rescue SocketError
        raise SocketError, 'Domain does not exist'
      end

      def verified?
        raise DomainOwnershipChecker::ItShouldBeOverridedError, 'It should be overrided'
      end
    end
  end
end
