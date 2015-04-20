class Entity < ActiveRecord::Base
  validates :type, presence: true
  validates :identifier, uniqueness: true, presence: true
end
