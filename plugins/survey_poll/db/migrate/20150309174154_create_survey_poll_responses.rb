class CreateSurveyPollResponses < ActiveRecord::Migration
  def change
    create_table :survey_poll_responses do |t|
      t.belongs_to :question
      t.belongs_to :brother
      t.text :response
      t.timestamps
    end
  end
end
