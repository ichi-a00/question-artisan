class Admin::AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to edit_admin_question_path(@answer.question_id), notice: "Answer was successfully created."
    else
      @question = Question.find(@answer.question_id)
      @formats = Question.formats
      flash[:alert] = 'error!'
      render template: "admin/questions/edit", status: :unprocessable_entity
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to edit_admin_question_path(@answer.question_id), notice: "Answer was successfully updated."
    else
      @question = Question.find(@answer.question_id)
      @formats = Question.formats
      flash[:alert] = 'error!'
      render template: "admin/questions/edit", status: :unprocessable_entity
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to edit_admin_question_path(@answer.question_id), notice: "Answer was successfully destroyed."
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :content, :is_correct, :order)
  end
end
