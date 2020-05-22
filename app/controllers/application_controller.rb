class ApplicationController < ActionController::Base

  def current_user
    return @current_user = User.find_by(id: session[:user_id])
  end
  # TODO do I need this here? Is this duplicate of users controller?

  def require_login
    if @current_user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to login_path # TODO Do I need this?
      return
    end
  end
end
