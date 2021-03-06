require 'rails_helper'

describe TagsController do
  let(:entity_type) { 'Product' }
  let(:entity_id) { 'abc-123' }
  let(:tags) { %w(Foo Bar) }
  let(:entity) { Entity.create(entity_type: entity_type, entity_id: entity_id) }

  before do
    tags.each { |tag| entity.tags.create(name: tag) }
  end

  describe "#create" do
    let(:new_tags) { ["Baz"] }
    let(:valid_params) do
      {entity_type: entity_type, entity_id: entity_id, tags: new_tags}
    end

    it "creates new tags" do
      expect {
        post :create, valid_params
      }.to change(Tag, :count).by(new_tags.count)
    end

    it "does not create tags that already exist" do
      expect {
        post :create, entity_type: entity_type, entity_id: entity_id, tags: tags
      }.not_to change(Tag, :count)
    end

    it "removes existing taggings" do
      expect {
        post :create, entity_type: entity_type, entity_id: entity_id, tags: []
      }.to change(entity.tags, :count).
      from(tags.count).to(0)
    end
  end

  describe "#show_entity" do
    let(:valid_params) { {entity_id: entity_id, entity_type: entity_type} }

    # TODO:  Add JSON schema matchers
    it "includes the entity tags" do
      get :show_entity, valid_params
      expect(JSON.parse(response.body)['tags']).to be_present
    end

    context "when the entity does not exist" do
      it "returns a 404" do
        get :show_entity, entity_id: 'N/A', entity_type: 'N/A'
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#delete_entity" do
    let(:valid_params) { {entity_id: entity_id, entity_type: entity_type} }

    it "deletes the entity" do
      delete :delete_entity, valid_params
    end

    it "deletes associated taggings" do
      expect { delete :delete_entity, valid_params }.to change(Tagging, :count)
    end
  end
end
