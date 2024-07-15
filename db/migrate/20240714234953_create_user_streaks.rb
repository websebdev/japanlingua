class CreateUserStreaks < ActiveRecord::Migration[8.0]
  def change
    create_table :user_streaks do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :current_streak, null: false, default: 0
      t.integer :max_streak, null: false, default: 0
      t.date :last_activity_date, null: false

      t.timestamps
    end
  end
end
