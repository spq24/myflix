class AddColumnsToReviewsTable < ActiveRecord::Migration
  def change
  	add_column :reviews, :user_id, :integer
  	add_column :reviews, :video_id, :integer
  	add_column :reviews, :content, :text
  	add_column :reviews, :rating, :integer
  	end
end
