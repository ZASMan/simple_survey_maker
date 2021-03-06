class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments, as: :commentable 
  validates :body, presence: true, uniqueness: true, length: { maximum: 2000 }
  # TODO: This needs to be reworked
  # validate :contains_profanity

  ANSWER_STATUSES = %w[flagged posted auto_flagged]
  CONTENT_FILTER = ContentFilter.first

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
  
  private
  
  # TODO: This needs to be reworked. Relying on a content_filter model with an array attribute is kind of bad
  # maybe we could make a model called censored_words or something?
  def contains_profanity
  	# Evaluate content here
    body_by_words.each do |word|
      downcased_filter_words = CONTENT_FILTER.filter_list.map { |word| word.downcase }
      if downcased_filter_words.include?(word)
        errors.add(:body, "Thank you for your submission! We will review and post shortly.")
      end
    end
  end
end
