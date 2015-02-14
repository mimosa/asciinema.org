# -*- encoding: utf-8 -*-

class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :imageable, polymorphic: true
  
  validates :user, presence: true

  mount_uploader :image, PhotoUploader
end