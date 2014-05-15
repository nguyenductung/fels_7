class Word < ActiveRecord::Base
  belongs_to :category
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  validates :content, presence: true
  validates :meaning, presence: true

  scope :learned_by, ->(user) do
    word_ids  = "SELECT DISTINCT word_id
                 FROM answers
                 WHERE answers.user_id = #{user.id}"
    where("id IN (#{word_ids})")
  end

  scope :not_learned_by, ->(user) do
    word_ids  = "SELECT DISTINCT word_id
                 FROM answers
                 WHERE answers.user_id = #{user.id}"
    where("id NOT IN (#{word_ids})")
  end
end