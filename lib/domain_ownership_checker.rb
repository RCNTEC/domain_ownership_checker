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

  # Configuration block
  def self.configure
    @config = Config.new
    yield @config if block_given?
  end

  def self.config
    @config ||= Config.new
  end

  class Config
    attr_accessor :skip_validation

    def initialize
      default_configuration
    end

    def default_configuration
      @skip_validation = false
    end
  end

  # Returns domain verification status
  #
  # @return [Boolean]
  #
  # @since 0.0.1
  def verified?
    return true if DomainOwnershipChecker.config.skip_validation
    providers = Providers.new(options)
    providers.verified?
  rescue
    @errors = providers.errors
    false
  end
end
