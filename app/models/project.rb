class Project < ApplicationRecord
  belongs_to :user
  has_many :steps
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true
  validates :supplies, presence: true
  validates :user, presence: true
end
