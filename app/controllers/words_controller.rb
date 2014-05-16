class WordsController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def index
    if !params[:word_type].nil? && !params[:category_id].nil?
      if params[:category_id].empty?
        @words = Word.all
      else
        category = Category.find_by id: params[:category_id]
        @words = category.words
      end
        
      if params[:word_type] == "learned"
        @words = @words.learned_by current_user
      elsif params[:word_type] == "not_learned"
        @words = @words.not_learned_by current_user
      end    
    else
      @words = Word.all
    end
    @words = @words.paginate page: params[:page], per_page: 20
  end
end
