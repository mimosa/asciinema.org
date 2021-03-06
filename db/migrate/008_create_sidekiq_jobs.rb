# -*- encoding: utf-8 -*-

class CreateSidekiqJobs < ActiveRecord::Migration
  def change
    create_table :sidekiq_jobs do |t|
      t.string :jid, limit: 128
      t.string :queue, limit: 128
      t.string :class_name, limit: 128
      t.text :args
      t.boolean :retry
      t.datetime :enqueued_at
      t.datetime :started_at
      t.datetime :finished_at
      t.string :status, limit: 16
      t.string :name
      t.text :result
    end

    add_index :sidekiq_jobs, :jid
    add_index :sidekiq_jobs, :queue
    add_index :sidekiq_jobs, :retry
    add_index :sidekiq_jobs, :class_name
    add_index :sidekiq_jobs, :enqueued_at
    add_index :sidekiq_jobs, :started_at
    add_index :sidekiq_jobs, :finished_at
    add_index :sidekiq_jobs, :status
  end
end
