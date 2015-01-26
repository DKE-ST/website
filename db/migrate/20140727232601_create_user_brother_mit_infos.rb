class CreateUserBrotherMitInfos < ActiveRecord::Migration
  def change
    create_table :user_brother_mit_infos do |t|
      t.belongs_to :brother
      t.string :mit_id, limit: 9
      t.text :majors
      t.text :minors
      t.text :concentration
      t.text :extracurriculars
      t.text :interests
      t.text :urops
      t.text :internships
      t.text :fav_classes
      t.integer :year

      t.timestamps
    end
    execute 'ALTER TABLE `user_brother_mit_infos` CHANGE `year` `year` INT( 4 )'
  end
end
