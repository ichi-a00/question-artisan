class Customer::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @questions = @customer.questions.includes(:tags).page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(@customer)
    end
  end

  def update
    if current_customer.update(customer_params)
      redirect_to customer_path(current_customer), notice: "Your account has been updated successfully."
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_customer.update_attribute(:is_valid, false)
    reset_session
    redirect_to root_path, notice: "退会しました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :email, :introduction, :image)
  end

end
