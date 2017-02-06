class AddProjectPhotoToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :project_photo, :string, null: false
  end
end
