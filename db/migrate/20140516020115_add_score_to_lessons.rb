class AddScoreToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :score, :integer
  end
end
