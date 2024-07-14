class AddContextToSituations < ActiveRecord::Migration[8.0]
  def change
    add_reference :situations, :context, null: false, foreign_key: true
  end
end
