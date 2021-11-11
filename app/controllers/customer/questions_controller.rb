class Customer::QuestionsController < ApplicationController
  before_action :set_question!, only: %i[ show edit update destroy ]
  before_action :authenticate_customer!, except: [:index, :show]
  before_action :ensure_correct_customer!, only: [:edit, :update, :destroy]
  before_action :set_format!, only: [:new, :create, :edit, :update, :answer_format]



  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.answers.build
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    #inding.pry
    if @question.save
      redirect_to @question, notice: "Question was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    #binding.pry
    if @question.update(question_params)
      redirect_to @question, notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to questions_url, notice: "Question was successfully destroyed."
  end


  def answer_format
    @question = Question.new
    @question.answers.build
    @format = params[:format]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question!
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(
        :customer_id,
        :title,
        :sentence,
        :format,
        :explanation,
        :question_image,
        :answer_image,
        :answered_time,
        :correct_answered_time,
        answers_attributes: [:id, :content, :is_correct, :order, :_destroy]
        )
    end

    def ensure_correct_customer!
      @question = Question.find(params[:id])
      unless @question.customer == current_customer
        flash[:alert] = 'error!'
        redirect_to questions_path
      end
    end

    def set_format!
      @formats = Question.formats
    end
end