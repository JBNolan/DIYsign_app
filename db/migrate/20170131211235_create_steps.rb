class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.text :step_description, null: false
      t.string :step_picture, null: false
      t.belongs_to :project, null: false
    end
  end
end
