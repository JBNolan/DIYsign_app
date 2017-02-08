class RemoveLikeTallyFromProjects < ActiveRecord::Migration[5.0]
  def up
    remove_column :projects, :like_tally
  end

  def down
    add_column :projects, :like_tally
  end
end
