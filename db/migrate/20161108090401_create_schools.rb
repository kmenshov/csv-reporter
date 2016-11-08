class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :sName, limit: 45, null: false
      t.string :sEmail, limit: 45, null: false

      t.timestamps null: false
    end
  end
end
