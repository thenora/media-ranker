class ApplicationController < ActionController::Base

  def current_user
    return @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    if !current_user
      flash[:error] = "You must log in to do that"
      redirect_to request.referrer
      return
    end
  end
end
