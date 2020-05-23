class VotesController < ApplicationController
  before_action :require_login, only: [:create]

  def create

    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])
    
    if user.nil? || work.nil?
      head :not_found
      return
    end
    
    if session[:user_id] # if user is logged in
      
      upvote = Vote.create(
        user_id: user.id, 
        work_id: work.id
      )
        if upvote.save 
          flash[:success] = 'Successfully upvoted!'
        else
          flash[:error] = 'You already voted for this work'
        end
      end
    redirect_back(fallback_location: root_path)
    return
  end
  
  
  private
  
  def votes_params
    params.require(:votes).permit(:user_id, :work_id, :created_at)
  end
end
