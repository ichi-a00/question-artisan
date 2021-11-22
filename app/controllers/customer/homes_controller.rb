class Customer::HomesController < ApplicationController
  def top
    if customer_signed_in?
      @questions = Question.includes(:tags, :favorites, :results).order(id: "desc").page(params[:page]).per(3)
    else
      @questions = Question.includes(:tags).order(id: "desc").page(params[:page]).per(3)
    end
  end
end
