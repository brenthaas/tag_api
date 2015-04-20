class Entity < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :entity_type, presence: true
  validates :identifier, uniqueness: true, presence: true
end
