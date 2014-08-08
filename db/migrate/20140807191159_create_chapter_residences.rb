class CreateChapterResidences < ActiveRecord::Migration
  def change
    create_table :chapter_residences do |t|
      t.string :name
      t.integer :floor
      t.integer :capacity
      t.timestamps
    end
    execute 'ALTER TABLE `chapter_residences` CHANGE `floor` `floor` INT( 1 )'
    execute 'ALTER TABLE `chapter_residences` CHANGE `capacity` `capacity` INT( 1 )'
  end
end
