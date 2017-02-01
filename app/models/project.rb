class Project < ApplicationRecord
  belongs_to :user
  has_many :steps

  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true
  validates :supplies, presence: true
  validates :user, presence: true
end
