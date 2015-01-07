class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.string :title
      t.text :desc
      t.belongs_to :brother
      t.string :color
      t.datetime :start
      t.datetime :end
      t.timestamps
    end
  end
end
