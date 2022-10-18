class IncomeAndPaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @income_and_payment = IncomeAndPayment.new
  end
  def create
    @income_and_payment = current_user.income_and_payments.build(income_and_payment_params)
    if @income_and_payment.save
      if @income_and_payment.income_or_payment == 1
        redirect_to incomes_income_and_payments_url
      else
        redirect_to payments_income_and_payments_url
      end
    else
      render 'income_and_payments/new'
    end
  end

  def select_item
    @detail_items = DetailItem.where(item_id: params[:item_id])    
  end

  def incomes
    @incomes = current_user.income_and_payments.where(income_or_payment: 1)
  end

  def payments
    @payments = current_user.income_and_payments.where(income_or_payment: 2)
  end

  private
    def income_and_payment_params
      params.require(:income_and_payment).permit(:item_id, :detail_item_id, :money_place_id, :date, :month_loop, :amount, :income_or_payment)
    end
end
