class CreateEpsilonMealPlans < ActiveRecord::Migration
  def change
    change_table :user_brother_dke_infos do |t|
      t.boolean :meal_plan, default: false
    end
  end
end
