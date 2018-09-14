class Answer < ApplicationRecord
  after_create :evaluate_body_content
  belongs_to :question
  has_many :comments, as: :commentable 
  validates :body, presence: true, length: { maximum: 2000 }

  ANSWER_STATUSES = %w[flagged posted auto_flagged]
  CONTENT_FILTER = ContentFilter.first

  def display_status
  	if flagged?
  	  return "Confession Flagged."
  	elsif posted?
  	  return "Confession Posted."
  	else
  	  body
  	end
  end

  def flagged?
    %w[auto_flagged flagged].include?(status)
  end

  def posted?
    status == "posted"
  end

  def body_long?
    body.length > 15
  end

  def show_link_message
    body_long? ? "(View More)" : "(View)"
  end

  def preview_body_if_long
    return "Flagged" if flagged?
    if body.present?
      if body_long?
        body[0, 15] + "..."
      else
        body
      end
    else
      ""
    end
  end

  def body_by_words
    body.split(" ")
  end

  def evaluate_body_content
  	# Evaluate content here
    body_by_words.each do |word|
      if CONTENT_FILTER.present? && CONTENT_FILTER.filter_list.present?
        if CONTENT_FILTER.filter_list.include?(word)
          update_attribute(:status, "auto_flagged")
          return
        else
          update_attribute(:status, "safe")
        end
      end
    end
  end
end
