class Lesson < ActiveRecord::Base
  has_many :answers, dependent: :destroy, autosave: true
  has_many :words, through: :answers
  belongs_to :category
  before_save :calculate_score

  private
    def calculate_score
      self.score = 0
      self.answers.each do |answer|
        self.score += 1 if Option.find_by(id: answer.option_id).is_correct
      end
    end
end
