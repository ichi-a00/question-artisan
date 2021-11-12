class Customer::QuestionsController < ApplicationController
  before_action :set_question!, only: %i[ show edit update destroy artisan result ]
  before_action :authenticate_customer!, except: [:index, :show, :artisan, :result]
  before_action :ensure_correct_customer!, only: [:edit, :update, :destroy]
  before_action :set_format!, only: [:new, :create, :edit, :update, :answer_format]
  before_action :initialize_answer, only: [:new, :answer_format]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
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
  end

  def artisan
  end

  def result
    @your_answers = params[:your_answers]
    @your_answers.shift
    @your_answers.map!{|x| x.to_i}
    #binding.pry

    if @your_answers == @question.correct_answers.ids
      @question.correct_answered_time += 1
    end

    @question.answered_time += 1

    @question.save


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

    def initialize_answer
      @question = Question.new

      if params[:format]
        @question.format = params[:format]
      else
        @question.format = "bool"
      end

      case @question.format
      when "bool"

        @question.answers.build(content: "○", is_correct: true)
        @question.answers.build(content: "×", is_correct: false)

      else
        @question.answers.build(is_correct: true)
      end

    end
end