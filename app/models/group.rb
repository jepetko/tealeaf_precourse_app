class Group < ActiveRecord::Base
  validates :name, :presence => true
  has_many :relationships
  has_many :users, through: :relationships
end
