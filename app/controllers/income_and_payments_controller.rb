class IncomeAndPaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @income_and_payment = IncomeAndPayment.new

  end

  def create
    @income_and_payment = current_user.income_and_payments.build(income_and_payment_params)
    if @income_and_payment.save
      if @income_and_payment.month_loop
        saved_month = 1
        three_year_to_month_minus_saved_maonth = 35
        (saved_month..three_year_to_month_minus_saved_maonth).each do |num|
          nex_month = [item_id: income_and_payment_params[:item_id],
                       detail_item_id: income_and_payment_params[:detail_item_id],
                       money_place_id: income_and_payment_params[:money_place_id],
                       date: income_and_payment_params[:date].to_date.since(num.month),
                       month_loop: income_and_payment_params[:month_loop],
                       amount: income_and_payment_params[:amount],
                       income_or_payment: income_and_payment_params[:income_or_payment]]
          current_user.income_and_payments.create(nex_month)
        end
        if @income_and_payment.income_or_payment == IncomeAndPayment::INCOMES
          flash[:success] = "登録に成功しました。"
          redirect_to incomes_income_and_payments_url
        else
          flash[:success] = "登録に成功しました。"        
          redirect_to payments_income_and_payments_url
        end
      else
        if @income_and_payment.income_or_payment == IncomeAndPayment::INCOMES
          flash[:success] = "登録に成功しました。"
          redirect_to incomes_income_and_payments_url
        else
          flash[:success] = "登録に成功しました。"        
          redirect_to payments_income_and_payments_url
        end
      end
    else
      flash.now[:danger] = "登録に失敗しました。"
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
