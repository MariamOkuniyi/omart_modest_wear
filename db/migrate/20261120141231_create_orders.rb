class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :province
      t.string :postal_code
      t.decimal :subtotal
      t.decimal :tax
      t.decimal :total
      t.string :status

      t.timestamps
    end
  end
end
