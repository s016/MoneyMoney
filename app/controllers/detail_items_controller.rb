class DetailItemsController < ApplicationController
  def index
    @detail_items = DetailItem.where(item_id: params[:item_id])
  end
end
