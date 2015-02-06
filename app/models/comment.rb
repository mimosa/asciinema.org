# -*- encoding: utf-8 -*-

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :asciicast, counter_cache: true

  validates :body, :asciicast, :user, presence: true
end