class AddCharacterIdToSentences < ActiveRecord::Migration[8.0]
  def change
    add_column :sentences, :character_id, :bigint
  end
end
