require 'spec_helper'

describe UsersController do

  render_views

  describe 'index' do
    before(:each) do
      10.times do |i|
        FactoryGirl.create(:user, name: "User #{i}")
      end
    end

    it 'lists all users' do
      get :index, :format => :json
      result = JSON.parse(response.body)
      expect(result.count).to be(10)
    end
  end

  describe 'show' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'shows the user' do
      get :show, { :id => @user.id, :format => :json }
      result = JSON.parse(response.body)
      expect(result['name']).to eq(@user.name)
    end
  end

  describe 'edit' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'edits the user' do
      get :edit, { :id => @user.id, :format => :json }
      result = JSON.parse(response.body)
      expect(result['name']).to eq(@user.name)
    end
  end

  describe 'update' do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'updates the user' do
      put :update, { :id => @user.id, :user => { :name => 'Update new user' } }
      expect(response).to redirect_to('/users')
      expect(User.find(@user.id).name).to eq('Update new user')
    end
  end

  describe 'create' do

    it 'shows the user' do
      expect{post(:create, { :user => { :name => 'Brand new user' }})}.to change{User.count}.by(1)
      expect(response).to redirect_to('/users')
      expect(User.last.name).to eq('Brand new user')
    end
  end

  describe 'destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it 'destroys the user' do
      expect { delete(:destroy, :id => @user) }.to change{User.count}.by(-1)
      expect(response).to redirect_to('/users')
    end
  end
end