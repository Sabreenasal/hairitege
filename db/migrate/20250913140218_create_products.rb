class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.text :description

      t.timestamps
    end
  end
end
