class CreateSurveyPollSurveys < ActiveRecord::Migration
  def change
    create_table :survey_poll_surveys do |t|
      t.string :title
      t.text :description
      t.belongs_to :officer
      t.boolean :display
      t.timestamps
    end
  end
end
