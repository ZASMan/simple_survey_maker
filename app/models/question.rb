class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  
  def has_autoflagged_answers?
    return false if answers.empty?
    answers.any? {|answer| answer.flagged?} 
  end
end
