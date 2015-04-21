require 'rails_helper'

describe EntitiesController do
  describe "#create" do
    let(:entity_type) { 'Product' }
    let(:entity_id) { 'abc-123' }

    def do_create(params)
      post :create, params
    end

    context "with valid parameters" do
      let(:valid_params) { {entity_type: entity_type, entity_id: entity_id} }

      it "returns 200 Success" do
        do_create(valid_params)
        expect(response.status).to eq(200)
      end

      it "creates a new entity" do
        expect{ do_create(valid_params) }.to change(Entity, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "raises 422 Unprocessible" do
        do_create({ entity_type: "Fail" })
        expect(response.status).to eq(422)
      end
    end
  end
end
