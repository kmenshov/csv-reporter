class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :familyName, limit: 45, null: false
      t.string :fEmail, limit: 45, null: false
      t.references :school, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
