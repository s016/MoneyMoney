class MoneyPlacesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @money_places = current_user.money_places
  end
  
  def new
    @money_place = MoneyPlace.new
  end

  def create
    @money_place = current_user.money_places.build(money_place_params)
    if @money_place.save
      flash[:success] = "登録に成功しました。"
      redirect_to  money_places_url
    else
      flash.now[:danger] = "登録に失敗しました。"
      render 'money_places/new'
    end
  end

  private
    def money_place_params
      params.require(:money_place).permit(:user_id, :name, :date, :amount)
    end
end
