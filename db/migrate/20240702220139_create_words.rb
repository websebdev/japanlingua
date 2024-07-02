class CreateWords < ActiveRecord::Migration[8.0]
  def change
    create_table :words do |t|
      t.string :content
      t.string :reading_hiragana
      t.string :reading_romaji
      t.string :translation
      t.references :sentence, null: false, foreign_key: true

      t.timestamps
    end
  end
end
