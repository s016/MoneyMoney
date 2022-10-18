class MoneyPlacesController < ApplicationController
  def index
    @money_places = MoneyPlace.all
  end
  def new
    @money_place = MoneyPlace.new
  end

  def create
    @money_place = current_user.money_places.build(money_place_params)
    if @money_place.save!
      redirect_to  money_places_url
    else
      render 'money_places/new'
    end
  end

  private
    def money_place_params
      params.require(:money_place).permit(:user_id, :name, :date, :amount)
    end
end
