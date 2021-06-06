class RenameVisibilityToVisible < ActiveRecord::Migration[6.1]
  def change
    rename_column :repositories, :visibility, :visible
  end
end
