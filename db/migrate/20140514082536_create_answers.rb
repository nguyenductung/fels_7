class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :option_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
