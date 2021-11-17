class Customer::HomesController < ApplicationController
  def top
    @tags = Question.tag_counts_on(:tags).most_used(20)
  end

  def ranking
  end

  def about
  end
end
