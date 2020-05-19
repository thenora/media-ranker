class PizzasController < ApplicationController

  def index
    @thin_crusts = Pizza.where(crust: "thin")
    @thick_crusts = Pizza.where(crust: "thick")
    @deep_crusts = Pizza.where(crust: "deep-dish")
  end

  def home
    @thin_crusts = Pizza.popular("thin")
    @thick_crusts = Pizza.where(crust: "thick")
    @deep_crusts = Pizza.where(crust: "deep-dish")
  end

  def show
    @pizza = Pizza.find_by(id: params[:id])
    if @pizza.nil?
      head :not_found
      return
    end
  end

  def new
    @pizza = Pizza.new
  end

  def create
    @pizza = Pizza.new(pizza_params) # Instantiate a new pizza
    if @pizza.save
      # flash[:success] = "Your pizza is on the menu!"
      redirect_to pizza_path(@pizza.id)
      return
    else # if save fails
      # flash.now[:error] = "Oops. We couldn't add your pizza to the menu."
      render :new, status: :bad_request # show the new pizza form again
  end

  def edit
    @pizza = Pizza.find_by(id: params[:id])

    if @pizza.nil?
      head :not_found
      return
    end 
  end

  def update
    @pizza = pizza.find_by(id: params[:id])

    if @pizza.nil? 
      head :not_found
      return
    elsif @pizza.update(pizza_params)
      # flash[:success] = "Pizza updated!"
      redirect_to pizza_path(@pizza.id) 
      return
    else # save failed
      # flash.now[:error] = "Oops! We couldn't update your pizza."
      render :edit, status: :bad_request # show the new pizza form view again
      return
    end
  end

  def destroy
    if @pizza.nil?
      head :not_found
      return
    end

    # TODO - what about votes when a pizza is destroyed?
    @pizza.destroy

    redirect_to pizza_path
    return
  end

  private

  def pizza_params
    return params.require(:pizza).permit(:crust, :name, :sauce, :cheese, :toppings)
  end

end
