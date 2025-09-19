class CreateRecommendations < ActiveRecord::Migration[8.0]
  def change
    create_table :recommendations do |t|
      t.integer :stylist_id
      t.integer :client_id
      t.references :product, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
