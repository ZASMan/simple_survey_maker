class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments, as: :commentable 
  validates :body, length: { maximum: 2000 }

  ANSWER_STATUSES = %w[flagged posted]

  def display_status
  	if status == "flagged"
  	  return "Confession Flagged."
  	elsif status == "posted"
  	  return "Confession Posted."
  	else
  	  body
  	end
  end

  def evaluate_body_content
  	# Evaluate content here
  end
end
