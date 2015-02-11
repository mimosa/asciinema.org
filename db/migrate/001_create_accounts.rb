# -*- encoding: utf-8 -*-

class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email, limit: 128 # 电邮
      t.string :mobile, limit: 128 # 手机
      t.string :name, limit: 16 # 姓名
      t.string :username, limit: 16
      t.string :single_access_token, null: false, limit: 128
      t.string :temporary_username
      t.string :theme_name

      t.string :crypted_password # 加密后的密码
      t.string :salt # 盐

      t.string :reset_token # 重置密码的验证码
      t.datetime :reset_sent_at # 

      t.timestamps
    end
    
    add_index :accounts, :single_access_token
    add_index :accounts, :username
    add_index :accounts, :email
  end
end