class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :content
      t.integer :word_id
      t.boolean :is_correct

      t.timestamps
    end
  end
end
