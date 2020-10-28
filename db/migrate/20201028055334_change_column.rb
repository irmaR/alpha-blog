class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :updates_at
    add_column :articles, :updated_at, :datetime
  end
end
