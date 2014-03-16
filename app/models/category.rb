class Category < ActiveRecord::Base
  has_many :videos, -> { order "Category ASC" }
  validates_presence_of :category

  def display_most_recent_videos
    videos.reorder("created_at DESC").take(6)
  end
end
