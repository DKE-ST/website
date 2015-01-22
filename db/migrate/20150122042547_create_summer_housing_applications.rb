class CreateSummerHousingApplications < ActiveRecord::Migration
  def change
    create_table :summer_housing_applications do |t|
      t.text :first_name
      t.text :last_name
      t.string :sex
      t.integer :age
      t.string :email
      t.integer :phone
      t.string :school
      t.string :dke_brother
      t.text :q1
      t.text :q2
      t.text :q3
      t.text :q4
      t.text :q5
      t.text :q6
      t.text :q7
      t.text :q8
      t.integer :room_pref
      t.string :finding
      t.boolean :lived_before
      t.boolean :car
      t.boolean :contacted
      
      t.timestamps
    end
  end
end
