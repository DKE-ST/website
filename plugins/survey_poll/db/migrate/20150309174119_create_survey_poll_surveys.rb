class CreateSurveyPollSurveys < ActiveRecord::Migration
  def change
    create_table :survey_poll_surveys do |t|

      t.timestamps
    end
  end
end
