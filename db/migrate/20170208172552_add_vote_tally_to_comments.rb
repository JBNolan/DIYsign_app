class AddVoteTallyToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :vote_tally, :integer, default: 0
  end
end
