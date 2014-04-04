require 'spec_helper'

feature 'User invites friend' do 
	scenario 'User successfully invites friend and invitation is accepted' do
		alice = Fabricate(:user)
		sign_in(alice)
		
		invite_a_friend
		friend_accepts_invitation
		friend_signs_in	
		friend_should_follow(alice)
		inviter_should_follow_friend(alice)

		clear_email
	end


	def invite_a_friend 
		visit new_invitation_path

		fill_in "Friend's Name", with: "John Doe"
		fill_in "Friend's Email Address", with: "john@example.com"
		fill_in "Message", with: "hello please join this site."
		click_button "send invitation"
		sign_out
	end

	def friend_accepts_invitation
		open_email "john@example.com"
		current_email.click_link "Accept this invitation"
		fill_in "Password", with: "Password"
		fill_in "Full Name", with: "John Doe"
		click_button "Sign Up"
	end

	def friends_sign_in
		fill_in "Email Address", with: "john@example.com"
		fill_in "password", with: "password"
		click_button "Sign in"
	end

	def friend_should_follow(user)
		click_link "People"
		expect(page).to have_content alice.full_name
		sign_out
	end

	def inviter_should_follow_friend(inviter)
		sign_in(alice)
		click_link "People"
		expect(page).to have_content "John Doe"
	end

end