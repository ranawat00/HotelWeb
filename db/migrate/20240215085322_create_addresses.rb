class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresesses do |t|
      t.string :house_no
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code
      t.references :property, null: false, foreign_key: { on_delete: :cascade }


      t.timestamps
    end
  end
end
