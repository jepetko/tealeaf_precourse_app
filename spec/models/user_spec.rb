require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = User.new(name: 'John')
    @invalid_user = User.new
  end

  it 'should have a name' do
    @user.should respond_to(:name)
    expect(@invalid_user).not_to be_valid
    expect(@invalid_user.errors[:name]).to include('can\'t be blank')
  end

  it 'should belong to multiple group' do
    expect(@user).to respond_to(:groups)
  end
end
