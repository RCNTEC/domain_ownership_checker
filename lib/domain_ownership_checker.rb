# Main class
#
# @since 0.0.1
class DomainOwnershipChecker
  class ItShouldBeOverridedError < StandardError; end

  attr_reader :domain, :code

  def initialize(domain:, code:)
    @domain = domain
    @code = code
  end

  # Returns domain verification status
  #
  # @return [Boolean]
  #
  # @since 0.0.1
  def verified?
    "#{domain}: #{code}"
  end
end
