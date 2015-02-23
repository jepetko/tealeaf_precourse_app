require 'rails_helper'

describe Group do
  before(:each) do
    @group = FactoryGirl.create(:group)
    2.times { |i| @group.users << FactoryGirl.create(:user, {name: "User #{i}"}) }
  end

  it 'has a name' do
    expect(@group).to respond_to(:name)
  end

  it 'has the assigned users' do
    expect(@group).to respond_to(:users)
    expect(@group.users.count).to be(2)
  end
end
