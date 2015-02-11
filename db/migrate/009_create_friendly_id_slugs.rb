class CreateFriendlyIdSlugs < ActiveRecord::Migration
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug, limit: 64, null: false
      t.integer  :sluggable_id, null: false
      t.string   :sluggable_type, limit: 64
      t.string   :scope, limit: 64
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type]
    add_index :friendly_id_slugs, [:slug, :sluggable_type, :scope], unique: true
    add_index :friendly_id_slugs, :sluggable_type
  end
end
