class ActualMoneiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @money_places = current_user.money_places
    @actual_moneies = ActualMoneyCollection.new(@money_places, nil)
  end

  def create
    @actual_moneies = ActualMoneyCollection.new(nil, actual_money_params)
    data_into_moneies = @actual_moneies.collection.map do |actual_money|
      current_user.actual_moneies.build(money_place_id: actual_money.money_place_id, amount: actual_money.amount, date: actual_money_collection_params[:date])
    end

    if ActualMoney::all_save(data_into_moneies)
      flash[:success] = "実際の残高を登録しました。"
      redirect_to root_path
    else
      flash.now[:danger] = "登録に失敗しました。"
      render "actual_moneies/new"
    end
  end

  private
    def actual_money_collection_params
      params.require(:actual_money_collection).permit(:date)
    end

    def  actual_money_params
      params.require(:actual_money).map do |actual|
        actual.permit(:user_id, :money_place_id, :date, :amount)
      end
    end
end
