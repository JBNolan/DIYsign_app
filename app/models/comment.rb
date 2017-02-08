class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :votes
  has_many :users, through: :votes

  validates :body, presence: true
  validates :user, presence: true
  validates :project, presence: true
  validates :vote_tally, presence: true, numericality: { only_integer: true}
end
