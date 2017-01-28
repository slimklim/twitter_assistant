class Tweet < ApplicationRecord

  belongs_to :user

  default_scope -> { order('created_at DESC') }

  validates :message, presence: true, length: { maximum: 140 }
  validates :url, :user_id, presence: true

  self.per_page = 10

end
