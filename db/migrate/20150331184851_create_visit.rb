class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.belongs_to :user
      t.belongs_to :business
      t.string :daily_code
    end
  end
end