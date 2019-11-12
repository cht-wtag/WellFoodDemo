class ItemsController < ApplicationController
  before_action :require_login
  def index
    @current_user = current_user.items.ids
    @items=Item.all
  end
  def show
    @item=Item.find(params[:id])

  end
  def new
   @item=current_user.items.build
  end
  def edit
    @item=current_user.items.find(params[:id])
  end
  def create
  @item=current_user.items.build(item_params)
    if  @item.save
      redirect_to item_path(@item), notice: "Item is created"
    else
      @errors=@item.errors.full_messages
      render :new
    end
  end
  def update
    @item=current_user.items.find(params[:id])

    if  @item.update_attributes(item_params)
      redirect_to item_path(@item), notice: "Item is created"
    else
      @errors=@item.errors.full_messages
      render :edit
    end
  end
  def destroy
    @item=current_user.items.find(params[:id])
   if  @item.destroy
    redirect_to items_path, notice: "you have deleted #{@item.name}"
   else
     @errors=@item.errors.full_messages
     render :new
   end
    end
  private
  def item_params
    params.require(:item).permit(:name,:description)
  end
end
