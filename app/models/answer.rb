class Answer < ApplicationRecord
  after_create :evaluate_body_content
  belongs_to :question
  has_many :comments, as: :commentable 
  validates :body, presence: true, length: { maximum: 2000 }

  ANSWER_STATUSES = %w[auto_flagged flagged posted]
  CONTENT_FILTER = ContentFilter.first

  def display_status
  	if status == "flagged"
  	  return "Confession Flagged."
  	elsif status == "posted"
  	  return "Confession Posted."
  	else
  	  body
  	end
  end

  def preview_body_if_long
    body.length > 50 ? body[0, 50] : body
  end

  def body_by_words
    body.split(" ")
  end

  def evaluate_body_content
  	# Evaluate content here
    body_by_words.each do |word|
      if CONTENT_FILTER.filter_list.include?(word)
        update_attribute(:status, "auto flagged")
      end
    end
  end
end
