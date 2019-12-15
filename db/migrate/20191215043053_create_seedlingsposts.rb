class CreateSeedlingsposts < ActiveRecord::Migration[5.2]
  def change
    create_table :seedlingsposts do |t|
      t.text :item
      t.text :product_regulation
      t.date :shipping_date
      t.text :scion
      t.text :rootstock
      t.integer :count
      t.text :location
      t.integer :order_unit
      t.text :remarks
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :seedlingsposts, [:user_id, :created_at]
  end
end
