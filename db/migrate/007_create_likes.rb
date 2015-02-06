# -*- encoding: utf-8 -*-

class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.uuid :user_id, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.uuid :asciicast_id, null: false, index: true
      t.foreign_key :asciicasts, dependent: :delete

      t.timestamps
    end
  end
end
