class Project < ApplicationRecord
  CATEGORIES = [
    ["Home Improvement", "Home Improvement"],
    ["Crafting", "Crafting"],
    ["Costumes", "Costumes"],
    ["Misc.", "Misc."]
  ]

  belongs_to :user
  has_many :steps
  has_many :comments

  validates :title, presence: true
  validates :description, presence: true
  validates :picture, presence: true
  validates :supplies, presence: true
  validates :user, presence: true
  validates :category, presence: true

  def self.search(search)
    where("title ILIKE ?", "%#{search}%")
  end
end
