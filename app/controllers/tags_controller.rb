class TagsController < ApplicationController
  def create
    entity = Entity.find_or_initialize_by(
               entity_type: params.require(:entity_type),
               identifier: params.require(:entity_id)
             )
    if entity.new_record?
      entity.save
    else
      entity.taggings.destroy_all
    end

    params.require(:tags).each do |tag|
      entity.tags.find_or_create_by(name: tag)
    end

    render json: {}
  end
end
