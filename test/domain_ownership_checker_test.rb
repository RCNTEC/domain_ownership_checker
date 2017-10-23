require 'test_helper'

describe DomainOwnershipChecker do
  let(:subject) { DomainOwnershipChecker.new(valid_attributes) }
  let(:valid_attributes) do
    {
      domain: 'gruz0.ru',
      filename: 'robots.txt',
      cname: 'mail.gruz0.ru',
      cname_alias: 'ghc.googlehosted.com'
    }
  end

  describe '#verified?' do
    describe 'valid attributes' do
      it 'returns true' do
        assert_equal true, subject.verified?
      end
    end

    describe 'invalid attributes' do
      describe '#verified?' do
        it 'returns false if non-existent domain' do
          valid_attributes[:domain] = 'domain.tld'
          assert_equal false, subject.verified?
          assert_equal 'Domain not found', subject.error
        end

        it 'returns false if invalid domain with protocol' do
          valid_attributes[:domain] = 'http://domain.tld'
          assert_equal false, subject.verified?
          assert_equal 'Domain not found', subject.error
        end
      end

      describe '#file_verified?' do
        it 'has non-existent file' do
          valid_attributes[:filename] = 'non-existent.txt'
          assert_equal false, subject.file_verified?
          assert_equal 'File not found', subject.error
        end
      end

      describe '#cname_verified?' do
        it 'hasn\'t cname' do
          valid_attributes[:cname] = 'non-existent-cname.gruz0.ru'
          assert_equal false, subject.cname_verified?
          assert_equal 'CNAME not found', subject.error
        end
      end
    end
  end
end
