class UsersController < ApplicationController
  before_action :require_login, only: [:index] # Note - example site displays all users even when not logged in, but I understand that isn't the intended experience.
  
  def index
      @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user # returning user
      session[:user_id] = user.id
      session[:username] = user.username
      
      flash[:success] = "Successfully logged in as existing user #{username}"
    else # if user doesn't exist
      user = User.create(username: username) 
      session[:user_id] = user.id
      session[:username] = user.username

      flash[:success] = "Successfully created new user #{user.username} with ID #{user.id}"
    end

    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

end
