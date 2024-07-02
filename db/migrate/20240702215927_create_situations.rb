class CreateSituations < ActiveRecord::Migration[8.0]
  def change
    create_table :situations do |t|
      t.string :title
      t.text :description
      t.integer :difficulty_level

      t.timestamps
    end
  end
end
