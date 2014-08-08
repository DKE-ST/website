class CreateChapterPublicPages < ActiveRecord::Migration
  def change
    create_table :chapter_public_pages do |t|
      t.string :pname
      t.belongs_to :position
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
