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

    describe 'skip_validation' do
      it 'returns true without a real check domain' do
        DomainOwnershipChecker.configure do |config|
          config.skip_validation = true
        end
        valid_attributes = {}
        assert_equal true, subject.verified?
      end
    end

    describe 'invalid attributes' do
      describe '#verified?' do
        it 'returns false if non-existent domain' do
          valid_attributes[:domain] = 'domain.tld'
          assert_equal false, subject.verified?
          assert_includes subject.errors, 'Domain not found'
        end

        it 'returns false if invalid domain with protocol' do
          valid_attributes[:domain] = 'http://domain.tld'
          assert_equal false, subject.verified?
          assert_includes subject.errors, 'Domain not found'
        end

        it 'returns false if it has non-existent file' do
          valid_attributes[:filename] = 'non-existent.txt'
          assert_equal false, subject.verified?
          assert_includes subject.errors, 'File not found'
        end

        # FIXME: It should be refactored because without filename this test won't be broken
        it 'returns false if it hasn\'t cname' do
          valid_attributes[:filename] = 'non-existent.txt'
          valid_attributes[:cname] = 'non-existent-cname.gruz0.ru'
          assert_equal false, subject.verified?
          assert_includes subject.errors, 'CNAME not found'
        end
      end
    end
  end
end
