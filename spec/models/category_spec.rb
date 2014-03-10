require 'spec_helper'

describe Category do

	it { should have_many(:videos)}

	describe "#recent_videos" do
		it "returns the videos in the reverse chronological order by created_at" do
			comedies = Category.create(category: "comedies")
			futurama = Video.create(title: "futurama", video_description: "space travel", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(title: "south park", video_description: "fatass", category: comedies)
			expect(comedies.recent_videos).to eq([south_park, futurama])
		end

		it "returns all the videos if there are less than 6 videos" do
			comedies = Category.create(category: "comedies")
			futurama = Video.create(title: "futurama", video_description: "space travel", category: comedies, created_at: 1.day.ago)
			south_park = Video.create(title: "south park", video_description: "fatass", category: comedies)
			expect(comedies.recent_videos.count).to eq(2)
		end

		it "returns 6 videos if there are more than 6 videos" do
			comedies = Category.create(category: "comedies")
			7.times { Video.create(title: "foo", video_description: "bar", category: comedies)}
			expect(comedies.recent_videos.count).to eq(6)
		end


		it "returns the most recent 6 videos" do
			comedies = Category.create(category: "comedies")
			7.times { Video.create(title: "foo", video_description: "bar", category: comedies)}
			tonights_show = Video.create(title: "talk show", video_description: "bar", category: comedies, created_at: 1.day.ago)
			expect(comedies.recent_videos.count).not_to include(tonights_show)
		end

		it "returns an empty array if the category does not have any videos" do
			comedies = Category.create(category: "comedies")
		end
	end
end