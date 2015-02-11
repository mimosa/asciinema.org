# -*- encoding: utf-8 -*-

class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.references :user, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.string :nickname
      t.string :provider, null: false, limit: 128
      t.string :uid, null: false, limit: 128

      t.timestamps
    end
    
    add_index :authorizations, [:provider, :uid]
  end
end