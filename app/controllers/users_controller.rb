class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: 3
  end
  
  def show
    @user = User.find_by id: params[:id]
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Framgia E-Learning System!"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update_attributes user_params
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
  end

  def following
    @title = "Following"
    @user = User.find_by id: params[:id]
    @allusers = @user.followed_users unless @user.nil?
    @users = @user.followed_users.paginate page: params[:page], per_page: 3 unless @user.nil?
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user = User.find_by id: params[:id]
    @allusers = @user.followers unless @user.nil?
    @users = @user.followers.paginate page: params[:page], per_page: 3 unless @user.nil?
    render "show_follow"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Before filters

    def correct_user
      @user = User.find_by id: params[:id]
      redirect_to root_url unless current_user? @user
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end