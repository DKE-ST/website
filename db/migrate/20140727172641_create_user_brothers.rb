class CreateUserBrothers < ActiveRecord::Migration
  def change
    create_table :user_brothers do |t|
      t.belongs_to :user
      t.text :first_name
      t.text :last_name
      t.string :phone, limit: 10
      t.text :email
      t.text :bio
      t.text :activities
      t.text :hobbies
      t.text :pro_team
      t.text :college_team
      t.text :movie
      t.text :quote
      t.text :hometown
      t.timestamps
    end
  end
end
