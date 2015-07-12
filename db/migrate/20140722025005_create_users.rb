class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uname, limit: 8, null: false
      t.integer :status, default: 0
      t.string :group, limit: 9, null: false
      t.string :chicken, limit: 10
      t.timestamps
    end
    add_index :users, :uname, unique: true
  end
end
