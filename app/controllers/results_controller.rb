class ResultsController < ApplicationController
  def index
    @incomes = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::INCOMES)
    @result_incomes = Result.result_income_and_payment(@incomes)

    @payments = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::PAYMENTS)
    @result_payments = Result.result_income_and_payment(@payments)
  end
end