class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: [:destroy]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @inventory_foods = @food.inventory_foods
    @inventory_foods.destroy_all
    @food.recipe_foods.destroy_all
    return unless @food.destroy

    flash[:notice] = 'Food was successfully destroyed.'
    redirect_to foods_url
  end


  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
