# -*- encoding: utf-8 -*-

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      
      t.uuid :user_id, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.uuid :asciicast_id, null: false, index: true
      t.foreign_key :asciicasts, dependent: :delete

      t.timestamps
    end
  end
end
