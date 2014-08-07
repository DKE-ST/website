class CreateUserBrotherDkeInfos < ActiveRecord::Migration
  def change
    create_table :user_brother_dke_infos do |t|
      t.belongs_to :brother
      t.text :p_name
      t.text :project
      t.text :past_pos
      t.belongs_to :big
      t.belongs_to :residence
      t.integer :p_class
      
      
      
      t.timestamps
    end
    execute 'ALTER TABLE `user_brother_dke_infos` CHANGE `p_class` `p_class` INT( 4 )'
  end
end
