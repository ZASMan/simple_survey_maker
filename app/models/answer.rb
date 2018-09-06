class Answer < ApplicationRecord
  belongs_to :question
  validates :body, profanity_filter: true
end
