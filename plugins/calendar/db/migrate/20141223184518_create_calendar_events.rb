class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.string :title
      t.text :desc
      t.belongs_to :officer
      t.date :date
      t.time :start
      t.time :end
      t.timestamps
    end
  end
end
