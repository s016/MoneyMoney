class DetailItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @detail_items = current_user.detail_items
  end
  def new
    @detail_item = DetailItem.new
  end

  def create
    @detail_item = current_user.detail_items.build(detail_item_params)
    if @detail_item.save!
      redirect_to detail_items_url
    else
      render 'detail_items/new'
    end
  end

  private
    def detail_item_params
      params.require(:detail_item).permit(:user_id, :item_id, :name)
    end
end
