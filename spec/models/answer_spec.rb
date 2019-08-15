require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:survey) { instance_double('Survey', id: 1) }
  let(:question) { instance_double('Question', survey_id: survey.id) }
  let(:content_filter) { double('ContentFilter', filter_list: ["dog"]) }
  it "disallows profane content to save" do
    answer = question.answers.build
    answer.body = 'dog'
    expect(answer.save!).to eq(false)
    expect(answer.errors.messages).to include("Wash your mouth out with soap, heathen!")
  end
end
