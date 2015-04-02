class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :daily_code
      t.string :password_hash

      t.timestamps
    end
  end
end