class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[destroy]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @recipe_foods = @recipe.recipe_foods
    @inventories = Inventory.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe Created Successfully' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_path, notice: 'Recipe Destroyed Successfully' }
      format.json { head :no_content }
    end
  end

  def shopping_list
    @recipe_id = params[:recipe_id]
    @inventory_id = params[:inventory_id]
    @recipe = Recipe.includes(recipe_foods: :food).find(@recipe_id)
    @inventory = Inventory.find(@inventory_id)
    inventory_foods_id = @inventory.foods.pluck(:id)
    @missing_foods = @recipe.recipe_foods.reject { |food_recipe| inventory_foods_id.include?(food_recipe.food_id) }
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    public = params[:public] == '1'
    if @recipe.update_attribute(:public, public)
      flash[:notice] = 'Recipe updated successfully.'
    else
      flash[:alert] = 'Failed to update recipe.'
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user)
  end
end
