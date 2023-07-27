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
    @user = current_user
    @inventory = @user.inventories.build(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully created.' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory = Inventory.find_by(id: params[:id])

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
