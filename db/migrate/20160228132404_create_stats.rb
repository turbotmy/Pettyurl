class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :title
      t.integer :httpstatus
      t.references :Shortened_urls, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
