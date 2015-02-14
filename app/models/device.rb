# -*- encoding: utf-8 -*-

class Device < ActiveRecord::Base

  UDIDError = Class.new(StandardError)

  belongs_to :user

  validates :user, :udid, presence: true
  validates :udid, uniqueness: true

  def self.for_udid(udid)
    self.find_by(udid: udid)
  end

  def reassign_to(target_user)
    return if target_user == user
    raise UDIDError if udid?

    user.merge_to(target_user)
  end

  private

    def udid?
      user.confirmed?
    end

end
