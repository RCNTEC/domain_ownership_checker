require_relative 'domain_ownership_checker/providers'

# Main class
#
# @since 0.0.1
class DomainOwnershipChecker
  class ItShouldBeOverridedError < StandardError; end
  class DomainOwnershipCheckerError < StandardError; end
  class DomainNotFoundError < StandardError; end
  class FileNotFoundError < StandardError; end
  class CnameNotFoundError < StandardError; end

  attr_reader :options, :errors

  def initialize(options)
    @options = options
  end

  # Returns domain verification status
  #
  # @return [Boolean]
  #
  # @since 0.0.1
  def verified?
    providers = Providers.new(options)
    providers.verified?
  rescue
    @errors = providers.errors
    false
  end
end
