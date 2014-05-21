# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(full_name: "Steve Q", password: "password", email: "foobar@foobar.com")
Category.create(category:"TV comedies")
Category.create(category:"comedies")
Category.create(category:"drama")
Video.create(title: "foo1", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo2", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo3", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo4", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo5", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo6", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo7", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "2")
Video.create(title: "foo8", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "3")
monk = Video.create(title: "foo9", video_description: "bar", small_cover: "/tmp/futurama.jpg", category_id: "3")
Review.create(user_id: 1, video_id: 2, rating: 3, content: "this is a really good show!")
Review.create(user_id: 1, video_id: 3, rating: 1, content: "this is a really bad show!")