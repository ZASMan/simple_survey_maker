class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  
  def has_autoflagged_answers?
    answers.any? {|answer| answer.flagged?} 
  end
end
