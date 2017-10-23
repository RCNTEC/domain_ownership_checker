require_relative 'domain_ownership_checker/providers'

# Main class
#
# @since 0.0.1
class DomainOwnershipChecker
  class ItShouldBeOverridedError < StandardError; end
  class DomainNotFoundError < StandardError; end
  class FileNotFoundError < StandardError; end
  class CnameNotFoundError < StandardError; end

  attr_reader :options, :error

  def initialize(options)
    @options = options
  end

  # Returns domain verification status
  #
  # @return [Boolean]
  #
  # @since 0.0.1
  def verified?
    Providers.verified?(options)
  rescue => e
    @error = e.message
    false
  end

  def file_verified?
    Providers.file_verified?(options)
  rescue => e
    @error = e.message
    false
  end

  def cname_verified?
    Providers.cname_verified?(options)
  rescue => e
    @error = e.message
    false
  end
end
