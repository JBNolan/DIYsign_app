class Project < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true
  validates :supplies, presence: true
end
