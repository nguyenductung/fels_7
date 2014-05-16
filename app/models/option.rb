class Option < ActiveRecord::Base
  belongs_to :word
  validates :content, presence: true
  #validates :is_correct, presence: true
end
