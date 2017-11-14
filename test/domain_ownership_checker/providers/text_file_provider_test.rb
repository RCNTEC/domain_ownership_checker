# TextFileProvider tests
#
# @since 0.0.1

require 'test_helper'

describe DomainOwnershipChecker::Providers::TextFileProvider do
  let(:subject) do
    DomainOwnershipChecker::Providers::TextFileProvider.new(attributes)
  end

  describe '#verified?' do
    describe 'valid attributes' do
      describe 'http' do
        let(:attributes) do
          {
            domain: 'gruz0.ru',
            filename: 'robots.txt'
          }
        end

        it 'returns true' do
          assert_equal true, subject.verified?
        end
      end
    end

    describe 'invalid attributes' do
      describe 'with non-existent domain' do
        let(:attributes) do
          {
            domain: 'non-existent-domain.tld'
          }
        end

        it 'raises exception if domain does not exist' do
          err = assert_raises(DomainOwnershipChecker::DomainNotFoundError) { subject }
          assert_equal 'Domain not found', err.message
        end
      end

      describe 'with non-existent file' do
        let(:attributes) do
          {
            domain: 'gruz0.ru',
            filename: 'non-existent.txt'
          }
        end

        it 'returns false if file does not exist' do
          err = assert_raises(DomainOwnershipChecker::FileNotFoundError) { subject.verified? }
          assert_equal 'File not found', err.message
        end
      end

      describe 'without filename' do
        let(:attributes) { { domain: 'gruz0.ru' } }

        it 'raises exception' do
          err = assert_raises(ArgumentError) { subject.verified? }
          assert_equal 'Options should be included :filename', err.message
        end
      end
    end
  end
end
