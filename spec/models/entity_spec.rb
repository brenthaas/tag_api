require 'rails_helper'

describe Entity do
  it { is_expected.to validate_presence_of :entity_type }
  it { is_expected.to validate_presence_of :identifier }
  context "identifier uniqueness" do
    let(:ident) { "abc-123" }
    let(:type) { "Product" }

    before { Entity.create(identifier: ident, entity_type: type) }

    it "is valid for a different entity_type" do
      expect(
        described_class.new(identifier: ident, entity_type: "Foo")
      ).to be_valid
    end

    it "is not valid if the identifier and entity_type are the same" do
      expect(
        described_class.new(identifier: ident, entity_type: type)
      ).not_to be_valid
    end
  end

  it { is_expected.to have_many :tags }
end
