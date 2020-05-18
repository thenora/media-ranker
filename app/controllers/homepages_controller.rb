class HomepagesController < ApplicationController
  def index
    @pizzas = Pizza.all
    
  end
end
