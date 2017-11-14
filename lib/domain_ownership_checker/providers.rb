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
    attr_reader :options, :errors

    def initialize(options)
      @options = options
    end

    def verified?
      @errors = []

      [TextFileProvider, DnsProvider].each do |provider|
        begin
          return true if provider.new(options).verified?
        rescue DomainNotFoundError, FileNotFoundError, CnameNotFoundError => e
          @errors << e.message
          next
        end
      end

      return if @errors.empty?

      @errors.uniq!
      raise DomainOwnershipCheckerError
    end
  end
end
