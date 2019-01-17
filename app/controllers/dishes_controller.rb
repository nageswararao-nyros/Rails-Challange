class DishesController < ApplicationController

  def index
    @dishes_query = Dish.where('name LIKE ?',"%#{params[:name]}%")
    @dishes = Dish.all
  end

  def search
    
    @dishes_search = Dish.where('name LIKE ?',"%#{params[:name]}%")

    @dish = params[:name]

    @taggings = Tagging.all

    if params[:filter]
      @dishes_search = Dish.order(params[:filter])
    elsif params[:ratingfilter]
      @dishes_search = Dish.where('rating > ? ', params[:ratingfilter] ) 
    elsif params[:taggingfilter]
      @dishes_search =  Dish.where(tagging_id: params[:taggingfilter])
    elsif params[:min_rangefilter] and params[:max_rangefilter]
      @dishes_search =  Dish.where('price BETWEEN ? AND ?', params[:min_rangefilter], params[:max_rangefilter])
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end
end
