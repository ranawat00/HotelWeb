class CreateReversations < ActiveRecord::Migration[7.1]
  def change
    create_table :reversations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :guests
      t.decimal :price, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :property, null: false, foreign_key: { on_delete: :cascade }


      t.timestamps
    end
  end
end
