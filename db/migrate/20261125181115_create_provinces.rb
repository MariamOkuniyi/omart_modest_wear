class CreateProvinces < ActiveRecord::Migration[8.1]
  def change
    create_table :provinces do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :tax_rate, precision: 7, scale: 5, null: false

      t.timestamps
    end

    add_index :provinces, :code, unique: true
  end
end