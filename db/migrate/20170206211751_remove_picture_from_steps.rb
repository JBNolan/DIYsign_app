class RemovePictureFromSteps < ActiveRecord::Migration[5.0]
  def up
    remove_column :steps, :step_picture
  end

  def down
    add_column :steps, :step_picture
  end
end
