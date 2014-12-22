class CreateHousePointsOfficerExtensions < ActiveRecord::Migration
  def change
    create_table :house_points_officer_extensions do |t|

      t.timestamps
    end
  end
end
