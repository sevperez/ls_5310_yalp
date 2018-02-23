class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.text :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :website
      t.time :open_hr
      t.time :close_hr
      t.integer :category_id
      t.integer :user_id
      t.string :slug
      
      t.timestamps
    end
  end
end
