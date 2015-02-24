class Group < ActiveRecord::Base
  validates :name, :presence => true
  has_many :relationships
  has_many :users, through: :relationships

  def self.available_groups(user)
    return [] if user.nil? || !user.is_a?(User)
    Group.all.select { |group| !user.groups.include?(group) }
  end
end
