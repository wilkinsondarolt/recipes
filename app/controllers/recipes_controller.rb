class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])

    raise ActionController::RoutingError, 'Not Found' if @recipe.blank?
  end
end
