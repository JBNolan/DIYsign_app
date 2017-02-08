class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :profile_photo, ProfilePhotoUploader

  has_many :projects
  has_many :comments
  has_many :votes
  has_many :comments, through: :votes

  validates_presence_of :zip
  validates_presence_of :username
  validates :username, presence: true
  validates :username, length: { maximum: 15 }
  validates :username, uniqueness: true
  validates :zip, presence: true, length: { is: 5 }, numericality: { only_integer: true }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
