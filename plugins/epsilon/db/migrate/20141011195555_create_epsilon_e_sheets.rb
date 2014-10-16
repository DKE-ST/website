class CreateEpsilonESheets < ActiveRecord::Migration
  def change
    create_table :epsilon_e_sheets do |t|
      t.belongs_to :dke_info
      t.date :date
      t.string :time, limit: 8
      t.string :e_type, limit: 8
      t.float :value
      t.text :comment
      t.timestamps
    end
  end
end
