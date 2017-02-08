class AddLikeTallyToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :like_tally, :integer, default: 0
  end
end
