class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_question_and_comments!

  def create
    @comment = @question.comments.new(comment_params)
    # admin
    @comment.customer_id = 0
    @comment.save!
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
