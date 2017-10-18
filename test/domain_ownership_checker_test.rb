require 'test_helper'

describe DomainOwnershipChecker do
  let(:subject) { DomainOwnershipChecker.new(valid_attributes) }
  let(:valid_attributes) do
    {
      domain: 'domain.tld',
      code: '123456'
    }
  end

  describe '#verified?' do
    it 'returns valid result' do
      expected = "#{valid_attributes[:domain]}: #{valid_attributes[:code]}"
      assert_equal expected, subject.verified?
    end
  end
end
