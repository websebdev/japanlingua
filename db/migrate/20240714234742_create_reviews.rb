class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true
      t.references :context, null: false, foreign_key: true
      t.datetime :next_review_date, null: false
      t.float :ease_factor, null: false, default: 2.5
      t.integer :interval, null: false, default: 0

      t.timestamps
    end
  end
end
