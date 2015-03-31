class CreateBusiness < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :address
      t.string :daily_code
    end
  end
end