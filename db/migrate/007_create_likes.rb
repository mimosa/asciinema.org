# -*- encoding: utf-8 -*-

class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.references :asciicast, null: false, index: true
      t.foreign_key :asciicasts, dependent: :delete

      t.timestamps
    end
  end
end
