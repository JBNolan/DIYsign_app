class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :picture, null: false
      t.string :supplies, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
