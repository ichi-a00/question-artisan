class Admin::QuestionsController < ApplicationController
  before_action :set_question!, only: %i(show edit update destroy)
  before_action :authenticate_admin!
  before_action :set_format!, only: [:new, :create, :edit, :update]

  # GET /questions
  def index
    # N+1
    @questions = Question.includes(:customer).all.page(params[:page]).per(10)
  end

  # GET /questions/1
  def show
    @comments = @question.comments.includes(:customer).order(id: "desc").page(params[:page]).per(10)
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to admin_question_path(@question), notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to admin_questions_path, notice: "Question was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question!
    @question = Question.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:customer_id, :title, :sentence, :format, :explanation, :question_image, :answer_image, :answered_time, :correct_answered_time)
  end

  def set_format!
    @formats = Question.formats
  end
end
