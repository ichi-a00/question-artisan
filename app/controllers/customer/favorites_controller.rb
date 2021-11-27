class Customer::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_question!

  def create
    favorite = current_customer.favorites.new(question_id: @question.id)
    favorite.save
  end

  def destroy
    favorite = current_customer.favorites.find_by(question_id: @question.id)
    favorite.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question!
    @question = Question.find(params[:question_id])
  end
end
