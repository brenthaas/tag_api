require 'rails_helper'

describe TagsController do
  describe "#create" do
    let(:type) { 'Product' }
    let(:identifier) { 'abc-123' }
    let(:tags) { %w(Foo Bar) }
    let(:valid_params) {{entity_type: type, entity_id: identifier, tags: tags}}
    let(:entity) { Entity.create(entity_type: type, identifier: identifier) }
    let(:orig_tags) { ["Baz"] }

    before do
      orig_tags.each { |tag| entity.tags.create(name: tag) }
    end

    it "creates new tags" do
      expect {
        post :create, valid_params
      }.to change(Tag, :count).by(tags.count)
    end

    it "does not create tags that already exist" do
      expect {
        post :create, entity_type: type, entity_id: identifier, tags: orig_tags
      }.not_to change(Tag, :count)
    end

    it "removes existing taggings" do
      expect {
        post :create, entity_type: type, entity_id: identifier, tags: []
      }.to change(entity.tags, :count).
      from(orig_tags.count).to(0)
    end
  end
end
