class UsersController < ApplicationController
  # skip_before_action :require_login, except: [:current]
  # TODO or should it be: before_action :require_login, only: [:current]


  
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

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:error] = "You must be logged in to see this page" # TODO ? What pages must I be logged in to view
      # TODO Should this be the error message for voting not logged in? "A problem occurred: You must log in to do that"
      redirect_to root_path
      return
    end
  end

  # private 

  # def user_params
  #   return params.require(:user).permit(:username)
  # end
end
