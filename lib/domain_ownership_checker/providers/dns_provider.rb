# DNS provider main class
#
# @since 0.0.1

class DomainOwnershipChecker
  class Providers
    # DnsProvider class
    #
    # @since 0.0.1
    class DnsProvider < BaseProvider
      attr_reader :cname, :cname_alias

      def initialize(options)
        super(options)
        validate_options!(options)
      end

      def verified?
        cname_present?
      end

      private

      def validate_options!(options)
        @cname = begin
                  options.fetch(:cname)
                rescue
                  raise ArgumentError, 'Options should be included :cname'
                end

        @cname_alias = begin
                  options.fetch(:cname_alias)
                rescue
                  raise ArgumentError, 'Options should be included :cname_alias'
                end
      end

      def cname_present?
        require 'resolv'

        records = Resolv::DNS.new.getresources(cname, Resolv::DNS::Resource::IN::CNAME)
        records.select { |record| record.name.to_s == cname_alias }.to_a.size == 1
      end
    end
  end
end
