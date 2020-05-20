class WorksController < ApplicationController
  def index
    @work = Work.all
    @movies = Work.sort_works("movie")
    @books = Work.sort_works("book")
    @albums = Work.sort_works("album")
  end

  def home
    @albums = Work.popular("album")
    @books = Work.popular("book")
    @movies = Work.popular("movie")
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
    @work = work.find_by(id: params[:id])

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
    if @work.nil?
      head :not_found
      return
    end

    # TODO - what about votes when a pizza is destroyed?
    @work.destroy

    redirect_to work_path
    return
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end