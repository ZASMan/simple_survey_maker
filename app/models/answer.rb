class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments, as: :commentableil
  validates :body, presence: true, length: { maximum: 2000 }

  ANSWER_STATUSES = %w[flagged posted]

  def evaluate_body_content
  	# Evaluate content here
  end
end
