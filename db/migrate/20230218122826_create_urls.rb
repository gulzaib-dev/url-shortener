# frozen_string_literal: true

# This migration creates the `urls` table, which is used to store shortened URLs in the application. The table has three columns:
# - `original_url`: a string column that stores the original URL that the shortened URL points to. This column cannot be null.
# - `slug`: a string column that stores a unique identifier for the shortened URL, consisting of five uppercase letters.
#    This column cannot be null, and is indexed for efficient lookups.
# - `clicked`: an integer column that stores the number of times the shortened URL has been clicked. This column defaults to 0.
class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_url, null: false
      t.string :slug, null: false
      t.integer :clicked, default: 0

      t.timestamps
    end
    add_index :urls, :slug, unique: true
  end
end
