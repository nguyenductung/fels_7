class Lesson < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :category
end
