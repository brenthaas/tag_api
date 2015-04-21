class TagsController < ApplicationController
  def create
    entity = Entity.find_or_initialize_by(
               entity_type: params.require(:entity_type),
               entity_id: params.require(:entity_id)
             )
    if entity.new_record?
      entity.save
    else
      entity.taggings.destroy_all
    end

    params.require(:tags).each do |tag|
      entity.tags << Tag.find_or_create_by(name: tag)
    end

    render json: {}
  end

  def show_entity
    find_entity
    render json: @entity, include: { tags: {only: :name} }
  end

  def delete_entity
    find_entity
    @entity.destroy
    render json: {}
  end

  def stats
    render json: Tag.joins(:taggings).group(:name).count
  end

  private

  def find_entity
    @entity = Entity.find_by!( entity_type: params.require(:entity_type),
                               entity_id: params.require(:entity_id) )
  end
end
