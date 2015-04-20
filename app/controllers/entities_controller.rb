class EntitiesController < ApplicationController
  def create
    @entity = Entity.find_or_create_by(identifier: params.require(:entity_id))
    @entity.update(entity_type: params[:entity_type])
    render json: @entity
  end
end