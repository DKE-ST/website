class CreateSurveyPollQuestions < ActiveRecord::Migration
  def change
    create_table :survey_poll_questions do |t|
      t.text :question
      t.integer :position
      t.belongs_to :survey
      t.string :qtype
      t.text :option
      t.text :option2
      
      t.timestamps
    end
  end
end
