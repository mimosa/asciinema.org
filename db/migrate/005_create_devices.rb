# -*- encoding: utf-8 -*-

class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :udid, null: false, limit: 128, index: true

      t.references :user, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.timestamps
    end
  end
end
