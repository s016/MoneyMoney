class IncomeAndPaymentsController < ApplicationController
  def new
    @income_and_payment = IncomeAndPayment.new
  end
  def create
    @income_and_payment = current_user.income_and_payments.build(income_and_payment_params)
    if @income_and_payment.save
      redirect_to new_income_and_payment_url
    else
      render 'income_and_payments/new'
    end
  end

  def select_item
    @detail_items = DetailItem.where(item_id: params[:item_id])    
  end

  private
    def income_and_payment_params
      params.require(:income_and_payment).permit(:item_id, :detail_item_id, :money_place_id, :date, :month_loop, :amount, :income_or_payment)
    end
end
