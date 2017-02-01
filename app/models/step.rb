class Step < ApplicationRecord
  belongs_to :project

  validates :step_description, presence: true
  validates :step_picture, presence: true
  validates :project, presence: true
end
