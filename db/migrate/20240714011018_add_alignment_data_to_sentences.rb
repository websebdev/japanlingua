class AddAlignmentDataToSentences < ActiveRecord::Migration[8.0]
  def change
    add_column :sentences, :alignment_data, :json
  end
end
