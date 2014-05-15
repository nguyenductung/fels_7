class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.string :meaning
      t.integer :category_id

      t.timestamps
    end
  end
end
