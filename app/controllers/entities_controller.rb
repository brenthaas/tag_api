class EntitiesController < ApplicationController
  def create
    @entity = Entity.find_or_create_by(
                entity_id: params.require(:entity_id),
                entity_type: params.require(:entity_type)
              )
    @entity.update(entity_type: params[:entity_type])
    render json: @entity
  end
end
