class StoreManagersController < ApplicationController
  def index
    @sm_list = StoreManager.all
  end

  def show
    @sm = StoreManager.find(params[:id])
  end

  def new
    @sm = StoreManager.new
  end

  def create
    @sm = StoreManager.new(sm_params)

    if @sm.save
      redirect_to @sm
    else
      redirect_to new_store_manager_path
    end
  end

  def edit
    @sm = StoreManager.find(params[:id])
  end

  def update
    @sm = StoreManager.find(params[:id])

    if @sm.update(sm_params)
      redirect_to @sm
    else
      redirect_to edit_store_manager_path
    end
  end

  def destroy
  end

  private

  def sm_params
    params.require(:store_manager).permit(:username, :first_name, :last_name, :password, :password_confirmation)
  end

end
