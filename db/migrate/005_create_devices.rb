# -*- encoding: utf-8 -*-

class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.uuid :udid, null: false, limit: 128, index: true

      t.uuid :user_id, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.timestamps
    end
  end
end
