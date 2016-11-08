class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :fName, limit: 45, null: false
      t.string :lName, limit: 45, null: false
      t.references :family, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
