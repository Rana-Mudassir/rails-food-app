class InventoryFoodsController < ApplicationController
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = InventoryFood.new(inventory_id: params[:inventory_id] )
    @foods = Food.all
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_food.build(inventory_food_params)
    respond_to do |format|
      if inventory_food.save
        flash[:notice] = 'Created an inventory food succesfully'
        format.html { redirect_to "/inventories/#{params[:id]}" }
      else
        flash[:notice] = 'Failed to create an inventory food. Try again'
        format.html { redirect_to "/inventories/#{params[:id]}/inventory_foods/new" }
      end
    end
  end

  def destroy
    inventory_food = InventoryFood.find(params[:id])
    inventory = inventory_food.inventory
    inventory_food.destroy
    flash[:notice] = 'Inventory food was successfully removed'
    redirect_to "/inventories/#{inventory.id}"
  end

  private

  def inventory_food_params
    params.require(:inventory_food).permit(:inventory_id, :food_id, :quantity)
  end
end
