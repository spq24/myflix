class Video < ActiveRecord::Base
	
	belongs_to :category
 	has_many   :reviews, order: "created_at DESC"
	validates  :title, presence: :true
	validates  :video_description, presence: :true
	
	mount_uploader :small_cover, SmallCoverUploader
	mount_uploader :large_cover, LargeCoverUploader
	

	def self.search_by_title(search_term)
		return [] if search_term.blank?
		where("title LIKE ?",  "%#{search_term}%" ).order("created_at DESC")
	end

	def average_rating
	    ratings = reviews.map(&:rating) - [nil]
	    average_rating = ratings.inject(:+).to_f / ratings.count
	    reviews.empty? ? 0.0 : average_rating.round(1)
  	end
end
