# -*- encoding: utf-8 -*-

class CreateExpiringTokens < ActiveRecord::Migration
  def change
    create_table :expiring_tokens do |t|
      t.references :user, null: false, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete
      
      t.string :token, null: false, limit: 128
      t.datetime :expires_at, null: false
      t.datetime :used_at

      t.timestamps
    end

    add_index :expiring_tokens, [:used_at, :expires_at, :token]
  end
end
