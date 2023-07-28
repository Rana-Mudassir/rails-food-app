class InventoryFoodsController < ApplicationController
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = InventoryFood.new
    @foods = Food.order(:name)
    render :new
  end
  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)
    if @inventory_food.food_id.blank?
      flash[:alert] = 'Please select a food.'
      render :new
      return
    end
    if @inventory_food.save
      flash[:notice] = 'Inventory Food added successfully!'
      redirect_to inventory_path(@inventory)
    else
      @foods = Food.order(:name)
      render :new
    end
  end
  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    inventory = @inventory_food.inventory
    @inventory_food.destroy
    flash[:notice] = 'Inventory food was successfully removed'
    redirect_to "/inventories/#{inventory.id}"
  end
  private
  def inventory_food_params
    params.require(:inventory_food).permit(:inventory_id, :food_id, :quantity)
  end
end