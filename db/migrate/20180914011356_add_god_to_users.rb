class AddGodToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :god, :boolean
  end
end
