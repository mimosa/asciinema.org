# -*- encoding: utf-8 -*-

class PlaybackOptions < ActiveInteraction::Base

  string :size,  default: 'small'
   float :speed, default: 1.0
  boolean :autoplay, :loop, :benchmark, default: false
  string :theme, default: Theme::DEFAULT

end