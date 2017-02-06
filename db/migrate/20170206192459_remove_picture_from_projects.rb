class RemovePictureFromProjects < ActiveRecord::Migration[5.0]
  def up
    remove_column :projects, :picture
  end

  def down
    add_column :projects, :picture
  end
end
