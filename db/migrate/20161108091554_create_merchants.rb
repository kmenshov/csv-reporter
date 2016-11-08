class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :mEmail, limit: 45, null: false
      t.string :mName, limit: 45, null: false
      t.decimal :commissionRate, precision: 3, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
