# Providers main class
#
# @since 0.0.1

require_relative 'providers/base_provider'
require_relative 'providers/text_file_provider'
require_relative 'providers/dns_provider'

class DomainOwnershipChecker
  # Providers main class
  #
  # @since 0.0.1
  class Providers
    def self.verified?(options)
      file_verified?(options) || cname_verified?(options)
    end

    def self.file_verified?(options)
      TextFileProvider.new(options).verified?
    end

    def self.cname_verified?(options)
      DnsProvider.new(options).verified?
    end
  end
end
