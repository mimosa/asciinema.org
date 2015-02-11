# -*- encoding: utf-8 -*-

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.text :body_html # Markdown 格式化后的 html
      
      t.references :user, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete

      t.references :asciicast, null: false, index: true
      t.foreign_key :asciicasts, dependent: :delete

      t.timestamps
    end
  end
end
