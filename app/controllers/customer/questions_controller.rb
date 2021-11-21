class Customer::QuestionsController < ApplicationController
  before_action :set_question!, only: %i[ show edit update destroy artisan result ]
  before_action :authenticate_customer!, except: [:index, :show, :artisan, :result, :search]
  before_action :ensure_correct_customer!, only: [:edit, :update, :destroy]
  before_action :set_format!, only: [:new, :create, :edit, :update, :answer_format]
  before_action :initialize_answer, only: [:new, :answer_format]

  # GET /questions
  def index
    @content = params[:content]
    @questions = Question.includes(:tags, :tag_taggings).search(@content).page(params[:page]).per(20)
    @tags = Question.tag_counts_on(:tags).order('count DESC')
    #binding.pry
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
    impressionist(@question, nil, unique: [:impressionable_id, :ip_address])
    @tags = @question.tag_counts_on(:tags).order('count DESC')
  end

  #too fat
  def result
    #回答セット
    @your_answers = params[:your_answers]
    @correct = false
    @rankup = false

    #回答判定
    if  @question.format == "writing"
      if @question.correct_answers.where(content:"#{@your_answers}").exists?
        @correct = true
      end
    else
      @your_answers.map!{|x| x.to_i}
      if @question.correct_answers.ids  == @your_answers
        @correct = true
      end
    end

    #回答数更新
    if @correct
      @question.correct_answered_time += 1
    end
    @question.answered_time += 1
    @question.save!

    #ユーザ登録済みなら、クリア状況と経験値更新
    if customer_signed_in?
      #クリア状況
      if @question.result?(current_customer)
        result = current_customer.results.find_by(question_id: @question.id)
      else
        result = current_customer.results.new(question_id: @question.id)
      end
      result.trial_count += 1
      if @correct
        result.is_cleared = true
      end
      result.save!

      #解く側の経験値
      if @correct
        current_customer.experience_point += ENV["CORRECT_EXP"].to_i
      else
        current_customer.experience_point += ENV["INCORRECT_EXP"].to_i
      end
      current_customer.save!
      @rankup = current_customer.rankup?

      #解かれた側の経験値
      if current_customer != @question.customer
        @question.customer.experience_point += ENV["ANSWERED_EXP"].to_i
        @question.customer.save!
        @question.customer.rankup?
      end
    end
  end

  def get_tag_search
    @tags = Question.tag_counts_on(:tags).where('name LIKE(?)', "%#{params[:key]}%")
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
        :tag_list,
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
        #最初は○×をセット
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