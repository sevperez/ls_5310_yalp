class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :content
      t.integer :user_id
      t.integer :business_id
      
      t.timestamps
    end
  end
end
