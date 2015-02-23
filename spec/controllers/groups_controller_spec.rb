require 'spec_helper'

describe GroupsController do

  render_views

  describe 'index' do
    before(:each) do
      10.times do |i|
        FactoryGirl.create(:group, name: "Group #{i}")
      end
    end

    it 'lists all groups' do
      get :index, :format => :json
      result = JSON.parse(response.body)
      expect(result.count).to be(10)
    end
  end

  describe 'show' do
    before(:each) do
      @group = FactoryGirl.create(:group)
    end

    it 'shows the group' do
      get :show, { :id => @group.id, :format => :json }
      result = JSON.parse(response.body)
      expect(result['name']).to eq(@group.name)
    end
  end

  describe 'edit' do
    before(:each) do
      @group = FactoryGirl.create(:group)
    end

    it 'edits the group' do
      get :edit, { :id => @group.id, :format => :json }
      result = JSON.parse(response.body)
      expect(result['name']).to eq(@group.name)
    end
  end

  describe 'update' do

    before(:each) do
      @group = FactoryGirl.create(:group)
    end

    it 'updates the group' do
      put :update, { :id => @group.id, :group => { :name => 'Updated new group' } }
      expect(response).to redirect_to('/groups')
      expect(Group.find(@group.id).name).to eq('Updated new group')
    end
  end

  describe 'create' do

    it 'shows the group' do
      expect{post(:create, { :group => { :name => 'Brand new group' }})}.to change{Group.count}.by(1)
      expect(response).to redirect_to('/groups')
      expect(Group.last.name).to eq('Brand new group')
    end
  end

  describe 'destroy' do
    before(:each) do
      @group = FactoryGirl.create(:group)
    end
    it 'destroys the group' do
      expect { delete(:destroy, :id => @group.id) }.to change{Group.count}.by(-1)
      expect(response).to redirect_to('/groups')
    end
  end
end