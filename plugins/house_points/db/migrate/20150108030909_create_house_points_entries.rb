class CreateHousePointsEntries < ActiveRecord::Migration
  def change
    create_table :house_points_entries do |t|
      t.belongs_to :dke_info
      t.belongs_to :officer
      t.float :value
      t.string :comment
      t.date :date
      t.timestamps
    end
  end
end
