class Tweet < ApplicationRecord
  validates :content, presence: true, length: {minimum: 1, maximum: 256}
  before_save :process_hashtags

  belongs_to :user
  has_and_belongs_to_many :hashtags

  def process_hashtags
    tags = Array.new
    content.scan(/#\w+/).each do |t|
      h = Hashtag.find_or_create_by(tag: t)
      tags << h
    end

    self.hashtags.each do |cur|
      unless tags.include?(cur)
        self.hashtags.delete(Hashtag.find_by tag: cur.tag)
      end
    end
    tags.each do |new_h|
      unless self.hashtags.include?(new_h)
        self.hashtags << new_h
      end
    end
  end

  def get_hashtags
    return self.hashtags.collect(&:tag).join(", ")
  end

  def self.search_by_tag(search)
    if search
      results = Tweet.joins(:hashtags).where('lower(hashtags.tag) LIKE ?', "%#{search.downcase}%")
      return results
    else
      
    end
  end

end
