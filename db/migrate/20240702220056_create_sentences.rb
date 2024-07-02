class CreateSentences < ActiveRecord::Migration[8.0]
  def change
    create_table :sentences do |t|
      t.text :content
      t.references :situation, null: false, foreign_key: true
      t.text :translation

      t.timestamps
    end
  end
end
