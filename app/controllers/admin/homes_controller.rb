class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    # csv出力用
    respond_to do |format|
      format.html
      format.csv do |csv|
        if params[:type] == "question"
          @questions = Question.all
          question_export(@questions)
        elsif params[:type] == "answer"
          @answers = Answer.all
          answer_export(@answers)
        end
      end
    end
  end

  # csv export
  def question_export(questions)
    csv_data = CSV.generate do |csv|
      header = %w(id customer_id title sentence format explanation)
      csv << header
      questions.each do |question|
        # customer_id = admin
        values = [
          question.id,
          0,
          question.title,
          question.sentence,
          question.format,
          question.explanation,
        ]
        csv << values
      end
    end
    send_data(csv_data, filename: "questions.csv")
  end

  def answer_export(answers)
    csv_data = CSV.generate do |csv|
      header = %w(id question_id content is_correct)
      csv << header
      answers.each do |answer|
        values = [answer.id, answer.question_id, answer.content, answer.is_correct]
        csv << values
      end
    end
    send_data(csv_data, filename: "answers.csv")
  end

  # csv import
  def question_import
    Question.import(params[:file])
    redirect_to admin_root_path, notice: "Questions were successfully imported."
  end

  # csv import
  def answer_import
    Answer.import(params[:file])
    redirect_to admin_root_path, notice: "Answers wewe successfully imported."
  end
end
