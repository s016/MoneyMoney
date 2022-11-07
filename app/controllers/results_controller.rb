class ResultsController < ApplicationController

  def index
    @incomes = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::INCOMES)

    @payments = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::PAYMENTS)
  end
end