class LessonsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :show]
  before_action :correct_user, only: [:show]

  def new
    @category = Category.find_by id: params[:category_id]
    @lesson = Lesson.new
    if !cookies.permanent[:words].nil? &&
       !cookies.permanent[:category].nil? &&
       cookies.permanent[:category].to_i == @category.id
      restore_lesson      
    else
      new_lesson
    end
  end

  def create
    @lesson = Lesson.new lesson_params
    params[:answers].each do |word_id, option_id|
      @lesson.answers.build user_id: @lesson.user_id, word_id: word_id, option_id: option_id     
    end
    @lesson.save
    cookies.delete(:words)
    cookies.delete(:category)
    cookies.each do |key, value|
      cookies.delete key if key.start_with?("answers")
    end
    redirect_to @lesson
  end

  def show
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson.nil?
      @result_words = @lesson.words
      @answers = @lesson.answers
      @category = Category.find_by id: @lesson.category_id
    end
  end

  private

    def lesson_params
      params.require(:lesson).permit(:user_id, :category_id)
    end

    def correct_user
      @lesson = Lesson.find_by id: params[:id]
      @user = User.find_by id: @lesson.user_id unless @lesson.nil?
      redirect_to root_url unless current_user? @user
    end

    def new_lesson
      cookies.permanent[:words] = []
      cookies.permanent[:category] = @category.id
      cookies.each do |key, value|
        cookies.delete key if key.start_with?("answers")
      end

      @lesson_words = @category.words.sample(20)
      @lesson_words.each do |word|
        cookies.permanent[:words] << word.id
      end
    end

    def restore_lesson
      @lesson_words = []
      cookies.permanent[:words].split('&').each do |id|
        @lesson_words << Word.find_by(id: id)
      end
    end
end
