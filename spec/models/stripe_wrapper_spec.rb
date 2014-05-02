require 'spec_helper'

describe StripeWrapper do
  describeStripeWrapper::Charge do
  	let(:valid_token) do
		Stripe::Token.create(
		  :card => {
		    :number => "4242424242424242",
		    :exp_month => 4,
		    :exp_year => 2015,
		    :cvc => 314
		  },
		).id
	end

	let(:declined_card_toekn) do
		Stripe::Token.create(
		  :card => {
		    :number => "40000000000002",
		    :exp_month => 4,
		    :exp_year => 2016,
		    :cvc => 314
		  },
		).id
	end

  	describe ".create" do
		it "make a successful charge", :vcr do
			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: valid_token,
			  description: "Charge for test@example.com"
			)

			expect(response.successful?).to be_successful
		end

		it "makes a card declined charge", :vcr do


			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: declined_card_token,
			  description: "An invalid charge"
			)

			expect(response).to_not be_successful
		end

		it "returns the error message for declined charges.", :vcr do
			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: declined_card_token,
			  description: "An invalid charge"
			)

			expect(response.error_message).to eq("Your card was declined.")
		end
  	end
  end

  describe StripeWrapper::Customer do
  	describe ".create" do
  		it "creates a customer with a valid card", :vcr do
  			alice = Fabricate(:user)
  			response = StripeWrapper::Customer.create(user: alice, card: valid_token)
  			expect(response).to be_successful
  		end
  		it "does not create a customer with a declined card" do
  			alice = Fabricate(:user)
  			response = StripeWrapper::customer.create(user: alice, card: declined_card_token)
  			expect(response).not_to be_successful
  		end

  		it "returns the error message for declined card", :vcr do
  			alice = Fabricate(:user)
  			response = StripeWrapper::Customer.create(
  				user: alice,
  				card: declined_card_token
  				)
  			expect(response.error_message).to eq("Your card was declined.")
  		end

  		it "returns the customer token for a valid card", :vcr do
			alice = Fabricate(:user)
  			response = StripeWrapper::Customer.create(user: alice, card: valid_token)
  			expect(response.customer_token).to be_present
		end
  	end
  end
end
