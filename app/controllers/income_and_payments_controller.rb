class IncomeAndPaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @income_and_payment = IncomeAndPayment.new

  end

  def create
    @income_and_payment = current_user.income_and_payments.build(income_and_payment_params)
    if @income_and_payment.save
      if @income_and_payment.income_or_payment == IncomeAndPayment::INCOMES
        redirect_to incomes_income_and_payments_url
      else
        redirect_to payments_income_and_payments_url
      end
    else
      render 'income_and_payments/new'
    end
  end

  def select_incomes
    @income_items = Item.all.where(income_or_payment: IncomeAndPayment::INCOMES)
    @income_detail_items = current_user.detail_items.where(income_or_payment: IncomeAndPayment::INCOMES)
  end

  def select_payments
    @payment_items = Item.all.where(income_or_payment: IncomeAndPayment::PAYMENTS)
    @payment_detail_items = current_user.detail_items.where(income_or_payment: IncomeAndPayment::PAYMENTS)
  end
  
  def select_item
    @detail_items = current_user.detail_items.where(item_id: params[:item_id])
  end

  def incomes
    @incomes = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::INCOMES)
  end

  def payments
    @payments = current_user.income_and_payments.where(income_or_payment: IncomeAndPayment::PAYMENTS)
  end

  private
    def income_and_payment_params
      params.require(:income_and_payment).permit(:item_id, :detail_item_id, :money_place_id, :date, :month_loop, :amount, :income_or_payment)
    end
end
