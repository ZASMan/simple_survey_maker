class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments, as: :commentable 
  validates :body, presence: true, uniqueness: true, length: { maximum: 2000 }
  validate :contains_profanity?

  ANSWER_STATUSES = %w[flagged posted auto_flagged]
  CONTENT_FILTER = ContentFilter.all[0]

  def display_status_class
    return "text-success" if posted?
    return "text-warning" if flagged?
    return "text-info"
  end

  def date_index
    "Anonymous Confession " +
    created_at.strftime("%m/%y") + " #" + id.to_s
  end

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

  def contains_profanity?
  	# Evaluate content here
    body_by_words.each do |word|
      if CONTENT_FILTER.present? && CONTENT_FILTER.filter_list.present?
        if CONTENT_FILTER.filter_list.include?(word)
          errors.add(:body, "Wash your mouth out with soap, heathen!")
        end
      end
    end
  end
end
