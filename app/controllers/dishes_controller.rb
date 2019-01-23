class DishesController < ApplicationController

  def index
    @dishes_query = Dish.all
  end

  def search
  
    @locations = []
    
    gon.locations = @locations

    @dishes_search = Dish.where('name LIKE ?',"%#{params[:name]}%")

    @dishes_search.find_each do |dish|
      dish.restaurants.each do |res|
        @locations.push(res.location)
      end
    end 
   
    
    @taggings = Tagging.all

    if params[:filter]
      @dishes_search =  Dish.order(params[:filter]).where('name LIKE ?',"%#{params[:name]}%")
     
    elsif params[:ratingfilter]
      @dishes_search = Dish.where('rating > ? ', params[:ratingfilter] ).where('name LIKE ?',"%#{params[:name]}%")

    elsif params[:taggingfilter]
      @dishes_search =  Dish.where(tagging_id: params[:taggingfilter]).where('name LIKE ?',"%#{params[:name]}%")
          
    elsif params[:min_rangefilter] and params[:max_rangefilter]
      @dishes_search =  Dish.where('price BETWEEN ? AND ?', params[:min_rangefilter], params[:max_rangefilter]).where('name LIKE ?',"%#{params[:name]}%")

    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end

  private

  def dish_params
   params.permit(:name, :filter)
  end
end
