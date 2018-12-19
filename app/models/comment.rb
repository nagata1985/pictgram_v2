class Comment < ApplicationRecord

  validates :text, presence: true
  validates :topic_id, presence: true

  belongs_to :topic

end
