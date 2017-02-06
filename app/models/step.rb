class Step < ApplicationRecord
  mount_uploader :step_photo, StepPhotoUploader

  belongs_to :project

  validates :step_description, presence: true
  validates :step_photo, presence: true
  validates :project, presence: true
end
