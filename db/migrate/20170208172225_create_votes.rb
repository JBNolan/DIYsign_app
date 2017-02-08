class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :comment, null: false
      t.boolean :voted, default: false
    end
  end
end
