class CreateUserShadows < ActiveRecord::Migration
  def change
    create_table :user_shadows, id: false do |t|
      t.string :uname, limit: 8, null: false
      t.belongs_to :user
      t.text :passwd, null: false
      t.timestamps
    end
    execute "ALTER TABLE user_shadows ADD PRIMARY KEY (uname);"
  end
end
