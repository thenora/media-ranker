class ApplicationController < ActionController::Base

  def current_user
    return @current_user = User.find_by(id: session[:user_id])
  end
  # TODO do I need this here? Is this duplicate of users controller?

  def require_login
    if !current_user
      flash[:error] = "You must log in to do that" # TODO this is showing up when voting
      redirect_to request.referrer # TODO Do I need this?
      return
    end
  end
end
