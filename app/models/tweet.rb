class Tweet < ApplicationRecord
  validates :content, presence: true, length: {minimum: 1, maximum: 256}
  before_save :process_hashtags

  belongs_to :user
  has_and_belongs_to_many :hashtags

  def process_hashtags
    content.scan(/#\w+/).each do |t|
      h = Hashtag.find_or_create_by(tag: t)
      self.hashtags << h
    end
  end

end
