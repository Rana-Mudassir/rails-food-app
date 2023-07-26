class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
    @food = Food.new
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_path(@inventory), notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @inventory
      @inventory.destroy
      respond_to do |format|
        format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to inventories_url, notice: 'Inventory does not exist.' }
        format.json { head :no_content }
      end
    end
  end
  

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
