class CreateShortenedUrl < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.integer :submitter_id

      t.string :short_url
      t.string :long_url
    end
    add_index :shortened_urls, :short_url, :unique => true
    add_index :shortened_urls, :submitter_id
  end
end
