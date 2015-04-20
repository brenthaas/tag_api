require 'rails_helper'

describe EntitiesController do
  describe "#create" do
    let(:type) { 'Product' }
    let(:identifier) { 'abc-123' }

    def do_create(params)
      post :create, params
    end

    context "with valid parameters" do
      let(:valid_params) { {entity_type: type, entity_id: identifier} }

      it "returns 200 Success" do
        do_create(valid_params)
        expect(response.status).to eq(200)
      end

      it "creates a new entity" do
        expect{ do_create(valid_params) }.to change(Entity, :count).by(1)
      end

      context "when an entity already exists" do
        let(:orig_type) { "Foo" }
        let(:entity) { Entity.find_by_identifier(identifier) }

        before { Entity.create(identifier: identifier, entity_type: orig_type) }

        it "overwrites the existing entity_type" do
          expect {
            do_create(valid_params)
          }.to change{ entity.reload.entity_type }.
          from(orig_type).to(type)
        end
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
