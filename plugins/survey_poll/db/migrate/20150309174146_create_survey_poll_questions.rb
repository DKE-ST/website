class CreateSurveyPollQuestions < ActiveRecord::Migration
  def change
    create_table :survey_poll_questions do |t|

      t.timestamps
    end
  end
end
