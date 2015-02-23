class User < ActiveRecord::Base
  validates :name, :presence => true
  has_many :relationships
  has_many :groups, :through => :relationships
end
