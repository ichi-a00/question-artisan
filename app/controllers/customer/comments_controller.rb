class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_question_and_comments!

  def create
    @comment = @question.comments.new(comment_params)
    @comment.customer_id = current_customer.id
    @comment.save
  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question_and_comments!
    @question = Question.find(params[:question_id])
    @comments = @question.comments.includes(:customer).order(id: "desc").page(params[:page]).per(10)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
