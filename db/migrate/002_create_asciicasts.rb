# -*- encoding: utf-8 -*-

class CreateAsciicasts < ActiveRecord::Migration
  def change
    create_table :asciicasts, id: false do |t|
      t.uuid :id, primary_key: true, index: true
      t.uuid :user_id, index: true
      t.foreign_key :accounts, column: :user_id, dependent: :delete
      t.string :title
      t.float :duration, null: false
      t.string :terminal_type
      t.integer :terminal_columns, null: false
      t.integer :terminal_lines, null: false
      t.string :command
      t.string :shell
      t.string :uname
      t.boolean :featured, default: false
      t.boolean :time_compression, null: false, default: true
      t.string :stdin_data
      t.string :stdin_timing
      t.string :stdout_data
      t.string :stdout_timing
      t.string :stdout_frames
      t.integer :likes_count, null: false, default: 0
      t.integer :views_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.text :description
      t.text :snapshot
      t.timestamps
      t.string :user_agent
      t.string :theme_name
      t.float :snapshot_at
    end

    add_index :asciicasts, :created_at
    add_index :asciicasts, :featured
    add_index :asciicasts, :likes_count
  end
end