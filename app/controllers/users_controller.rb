class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users.to_json }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user.to_json }
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user.to_json }
    end
  end

  def update
    user_hash = params[:user]
    @user = User.find(params[:id])
    if user_hash[:groups]
      @user.groups << Group.where(id: user_hash[:groups])
    end
    if user_hash[:name]
      @user.name = user_hash[:name]
    end
    @user.save!
    respond_to do |format|
      format.html { redirect_to action: :index}
      format.json { render json: @user.to_json }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: @user.to_json }
    end
  end

  def create
    user_hash = params[:user]
    @user = User.create!(name: user_hash[:name])
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { render json: @user.to_json }
    end
  end

  def destroy
    User.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.json { render json: @user.to_json }
    end
  end
end
