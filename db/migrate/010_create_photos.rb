# -*- encoding: utf-8 -*-

class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.references :imageable, polymorphic: true, type: 'string', limit: 11, index: true
      t.string :image
      t.string :user_agent
      t.string :remote_ip, limit: 15

      t.timestamps
    end
  end
end