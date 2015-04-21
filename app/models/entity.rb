class Entity < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :entity_type, presence: true
  validates :entity_id, presence: true, uniqueness: { scope: :entity_type }
end
