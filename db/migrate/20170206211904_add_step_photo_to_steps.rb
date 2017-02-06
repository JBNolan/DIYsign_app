class AddStepPhotoToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :steps, :step_photo, :string, null: false
  end
end
