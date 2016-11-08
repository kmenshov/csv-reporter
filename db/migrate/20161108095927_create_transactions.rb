class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :datetime, null: false
      t.integer :idTypeTransaction, null: false
      t.decimal :amount, precision: 13, scale: 2, null: false
      t.account :references, null: false
      t.merchant :references
      t.decimal :tCommission, precision: 13, scale: 2

      t.timestamps null: false
    end
  end
end
