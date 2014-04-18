require 'spec_helper'

describe StripeWrapper do
  describeStripeWrapper::Charge do
  	describe ".create" do
		it "make a successful charge", :vcr do
			token = Stripe::Token.create(
			  :card => {
			    :number => "4242424242424242",
			    :exp_month => 4,
			    :exp_year => 2015,
			    :cvc => 314
			  },
			).id

			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: token,
			  description: "Charge for test@example.com"
			)

			expect(response.successful?).to be_successful
		end

		it "makes a card declined charge", :vcr do
			token = Stripe::Token.create(
			  :card => {
			    :number => "40000000000002",
			    :exp_month => 4,
			    :exp_year => 2016,
			    :cvc => 314
			  },
			).id

			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: token,
			  description: "An invalid charge"
			)

			expect(response).to_not be_successful
		end

		it "returns the error message for declined charges.", :vcr do
			token = Stripe::Token.create(
			  :card => {
			    :number => "40000000000002",
			    :exp_month => 4,
			    :exp_year => 2016,
			    :cvc => 314
			  },
			).id

			response = StripeWrapper::Charge.create(
			  amount:400,
			  card: token,
			  description: "An invalid charge"
			)

			expect(response.error_message).to eq("Your card was declined.")
		end
  	end
  end
end
