class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :points
      t.string :password
    end
  end
end