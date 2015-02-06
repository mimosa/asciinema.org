# -*- encoding: utf-8 -*-

class Account < ActiveRecord::Base
  include ActiveUUID::UUID
end