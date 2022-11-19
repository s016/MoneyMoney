class ResultsController < ApplicationController
  before_action :authenticate_user!

  def index
    @incomes = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::INCOMES)
    @result_incomes = Result.result_income_and_payment(@incomes, IncomeAndPayment::INCOMES, current_user)

    @payments = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::PAYMENTS)
    @result_payments = Result.result_income_and_payment(@payments, IncomeAndPayment::PAYMENTS, current_user)

    @money_places = current_user.money_places
    @result_money_place = Result.result_money_place(@money_places, current_user)

  end
end