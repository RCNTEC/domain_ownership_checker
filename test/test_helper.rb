$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'domain_ownership_checker'
require 'domain_ownership_checker/providers/base_provider'
require 'domain_ownership_checker/providers/text_file_provider'
require 'domain_ownership_checker/providers/dns_provider'
