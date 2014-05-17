class Category < ActiveRecord::Base
  has_many :videos, -> { order "category_id ASC" }
  validates_presence_of :category
  validates_uniqueness_of :category

  def display_most_recent_videos
    videos.reorder("created_at DESC").take(6)
  end
end
