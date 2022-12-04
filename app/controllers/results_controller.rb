class ResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    @incomes = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::INCOMES)
    @result_incomes = Result.result_income_and_payment(@incomes, IncomeAndPayment::INCOMES, current_user)
    @income_names = Item.where(income_or_payment: IncomeAndPayment::INCOMES)

    @payments = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::PAYMENTS)
    @result_payments = Result.result_income_and_payment(@payments, IncomeAndPayment::PAYMENTS, current_user)

    @money_places = current_user.money_places
    @result_money_place = Result.result_money_place(@money_places, current_user)
  end

  def open_item
    @detail_item_names = DetailItem.where(user_id: current_user.id, item_id: params_item_id[:id])
    @detail_items = Result.result_detail_items(current_user, params_item_id[:id])
    @item_id = params_item_id[:id]
  end

  private
    def params_item_id
      params.permit(:id)
    end
end