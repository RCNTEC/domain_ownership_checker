# BaseProvider tests
#
# @since 0.0.1

require 'test_helper'

describe DomainOwnershipChecker::Providers::BaseProvider do
  let(:subject) { DomainOwnershipChecker::Providers::BaseProvider.new(attributes) }
  let(:attributes) { { domain: 'gruz0.ru' } }

  describe '#domain_exists?' do
    describe 'valid attributes' do
      it 'returns true' do
        assert_equal true, subject.domain_exists?
      end
    end

    describe 'invalid attributes' do
      let(:attributes) { { domain: 'domain.tld' } }

      it 'raises exception if domain does not exist' do
        err = assert_raises(DomainOwnershipChecker::DomainNotFoundError) { subject }
        assert_equal 'Domain not found', err.message
      end
    end
  end

  describe '#verified?' do
    it 'raises exception because #verified? is abstract method and should be overrided' do
      err = assert_raises(DomainOwnershipChecker::ItShouldBeOverridedError) { subject.verified? }
      assert_equal 'It should be overrided', err.message
    end

    describe 'invalid attributes' do
      describe 'are not present' do
        let(:attributes) {}

        it 'raises exception' do
          err = assert_raises(ArgumentError) { subject.verified? }
          assert_equal 'Options should be provided', err.message
        end
      end

      describe 'without domain' do
        let(:attributes) { { code: '123456' } }

        it 'raises exception' do
          err = assert_raises(ArgumentError) { subject.verified? }
          assert_equal 'Options must contain :domain', err.message
        end
      end
    end
  end
end
