class WorksController < ApplicationController
  # Note: no before action because the example site lets us view, delete, edit, and create works without logging in

  def index
    @movies = Work.sort_movies
    @books = Work.sort_books
    @albums = Work.sort_albums
  end

  def home
    @movies = Work.sort_movies[0..9]
    @books = Work.sort_books[0..9]
    @albums = Work.sort_albums[0..9]
    @spotlight = Work.spotlight
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) # Instantiate a new work

    if @work.save
      flash[:success] = "Your media was added!"
      redirect_to work_path(@work.id)
      return
    else # if save fails
      flash.now[:error] = "Oops. We couldn't add your media."
      render :new, status: :bad_request # show the new media form again
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end 
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil? 
      head :not_found
      return
    elsif @work.update(work_params)
      flash[:success] = "Media updated!"
      redirect_to work_path(@work.id) 
      return
    else # save failed
      flash.now[:error] = "Oops! We couldn't update your media."
      render :edit, status: :bad_request # show the new media form view again
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.destroy
      flash[:success] = "#{@work.title} was successfully deleted."
      redirect_to root_path
      return
    else
      flash.now[:error] = "Oops! This #{@work.category} could not be deleted."
      redirect_to work_path(@work.id)
      return
    end
  end


  
  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
