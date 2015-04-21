class Entity < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :entity_type, presence: true
  validates :identifier, presence: true, uniqueness: { scope: :entity_type }
end
