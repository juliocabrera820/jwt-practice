class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :description
      t.boolean :visibility

      t.timestamps
    end
  end
end
