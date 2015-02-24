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

    context 'user name changed' do
      it 'updates the user' do
        put :update, { :id => @user.id, :user => { :name => 'Update new user' } }
        expect(response).to redirect_to('/users')
        expect(User.find(@user.id).name).to eq('Update new user')
      end
    end

    context 'group was added' do

      before(:each) do
        @group = FactoryGirl.create(:group)
      end

      it 'adds the group to user\'s relationships' do
        expect { put :update, { :id => @user.id, :user => { :groups => @group.id }} }.to change{@user.groups.count}.by(1)
        expect(response).to redirect_to('/users')
        expect(@user.groups.last.name).to eq(@group.name)
      end
    end

    context 'name is nil or empty' do
      it 'rejects the passed values' do
        expect { put :update, { :id => @user.id, :user => { :name => '' }} }.not_to change { @user }
        expect(response.body).to match('can\'t be blank')
      end
    end

    context 'group doesnt exist' do
      it 'rejects the update of the user' do
        expect { put :update, { :id => @user.id, :user => { :groups => 1000 }} }.not_to change { @user }
        expect(response.body).to match('Group id 1000 doesn&#39;t exist')
      end
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