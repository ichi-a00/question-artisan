class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @customers = Customer.where(is_valid: true).order(rank: "desc").page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    if customer_signed_in?
      @questions = @customer.questions.
        includes(:tags, :favorites, :results).page(params[:page]).per(10)
    else
      @questions = @customer.questions.includes(:tags).page(params[:page]).per(10)
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(@customer)
    end
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customer_path(current_customer),
      notice: "Your account has been updated successfully."
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update_attribute(:is_valid, false)
    reset_session
    flash[:alert] = '退会しました。'
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :introduction, :image)
  end
end
