# DnsProvider tests
#
# @since 0.0.1

require 'test_helper'

describe DomainOwnershipChecker::Providers::DnsProvider do
  let(:subject) do
    DomainOwnershipChecker::Providers::DnsProvider.new(attributes)
  end

  describe '#verified?' do
    describe 'valid attributes' do
      let(:attributes) do
        {
          domain: 'ns01.ya.ru',
          cname: 'any.yandex.ru'
        }
      end

      it 'returns true' do
        assert_equal true, subject.verified?
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
          err = assert_raises(SocketError) { subject }
          assert_equal 'Domain does not exist', err.message
        end
      end

      describe 'with non-existent CNAME record' do
        let(:attributes) do
          {
            domain: 'ns01.ya.ru',
            cname: 'some-strange-record.yandex.ru'
          }
        end

        it 'returns false if file does not exist' do
          assert_equal false, subject.verified?
        end
      end

      describe 'without cname' do
        let(:attributes) { { domain: 'gruz0.ru' } }

        it 'raises exception' do
          err = assert_raises(ArgumentError) { subject.verified? }
          assert_equal 'Options should be included :cname', err.message
        end
      end
    end
  end
end
