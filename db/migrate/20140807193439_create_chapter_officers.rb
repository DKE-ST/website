class CreateChapterOfficers < ActiveRecord::Migration
  def change
    create_table :chapter_officers do |t|
      t.string :name
      t.text :title
      t.integer :position
      t.belongs_to :dke_info
      t.datetime :start_date
      t.boolean :disp
      t.text :contact
      t.string :email
      t.timestamps
    end
  end
end
