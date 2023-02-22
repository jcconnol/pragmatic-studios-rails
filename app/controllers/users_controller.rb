class UsersController < ApplicationController

  # order matters here
  before_action :require_sign_in, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @registrations = @user.registrations
    @liked_events = @user.liked_events
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "You can edit!"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy(user_params)
    session[:user_id] = nil
    redirect_to events_url, alert: "You gone boii!"
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to events_url unless @user == current_user
  end

  def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation)
  end
end
