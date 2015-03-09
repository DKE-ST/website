class CreateSurveyPollResponses < ActiveRecord::Migration
  def change
    create_table :survey_poll_responses do |t|

      t.timestamps
    end
  end
end
