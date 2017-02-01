class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :body, presence: true
  validates :user, presence: true
  validates :project, presence: true
end
