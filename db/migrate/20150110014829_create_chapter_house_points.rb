class CreateChapterHousePoints < ActiveRecord::Migration
  def change
    create_table :chapter_house_points do |t|
      t.belongs_to :dke_info
      t.belongs_to :officer
      t.float :value
      t.string :comment
      t.date :date
      t.timestamps
    end
  end
end
