class AddIconToContexts < ActiveRecord::Migration[8.0]
  def change
    add_column :contexts, :icon, :string
  end
end
