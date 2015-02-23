require 'rails_helper'

describe Relationship do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @group = FactoryGirl.create(:group)
  end

  it 'connects the user with the group' do
    rel = Relationship.new
    rel.group = @group
    rel.user = @user
    rel.save!

    expect(@group.users).to include(@user)
    expect(@user.groups).to include(@group)
  end

end
