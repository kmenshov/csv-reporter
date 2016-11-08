class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :datetime, null: false
      t.integer :idTypeTransaction, null: false
      t.decimal :amount, precision: 13, scale: 2, null: false
      t.references :account, index: true, foreign_key: true, null: false, :limit => 8
      t.references :merchant, index: true, foreign_key: true
      t.decimal :tCommission, precision: 13, scale: 2

      t.timestamps null: false
    end
  end
end
