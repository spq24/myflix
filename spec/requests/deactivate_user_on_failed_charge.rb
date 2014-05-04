require 'spec_helper'

describe 'Dactivate user on failed charge' do 
	let(:event_data) do
				{
		  "id"=> "evt_3xjcuDW2evP0yO",
		  "created"=> 1399065907,
		  "livemode"=> false,
		  "type"=> "charge.failed",
		  "data"=> {
		    "object"=> {
		      "id"=> "ch_3xjcEQv5YmHfLp",
		      "object"=> "charge",
		      "created"=> 1399065907,
		      "livemode"=> false,
		      "paid"=> false,
		      "amount"=> 999,
		      "currency"=> "usd",
		      "refunded"=> false,
		      "card"=> {
		        "id"=> "card_3xjcrLsqyl7vA6",
		        "object"=> "card",
		        "last4"=> "0341",
		        "type"=> "Visa",
		        "exp_month"=> 5,
		        "exp_year"=> 2017,
		        "fingerprint"=> "08H8G851qTw6JVIp",
		        "customer"=> "cus_3xWPVscjJFnKmC",
		        "country"=> "US",
		        "name"=> null,
		        "address_line1"=> null,
		        "address_line2"=> null,
		        "address_city"=> null,
		        "address_state"=> null,
		        "address_zip"=> null,
		        "address_country"=> null,
		        "cvc_check"=> "pass",
		        "address_line1_check"=> null,
		        "address_zip_check"=> null
		      },
		      "captured"=> false,
		      "refunds"=> [],
		      "balance_transaction"=> null,
		      "failure_message"=> "Your card was declined.",
		      "failure_code"=> "card_declined",
		      "amount_refunded"=> 0,
		      "customer"=> "cus_3xWPVscjJFnKmC",
		      "invoice"=> null,
		      "description"=> "tester",
		      "dispute"=> null,
		      "metadata"=> {},
		      "statement_description"=> null
		    }
		  },
		  "object"=> "event",
		  "pending_webhooks"=> 1,
		  "request"=> "iar_3xjcjQGwwWFq3U"
		}
	end

	it "deactivates a user with the web hook data from stripefor a charge failed", :vcr do
		alice = Fabricate(:user, customer_token:"cus_3xWPVscjJFnKmC")
		post "/stripe_events", event_data
		expect(alice.reload).not_to be_active
	end
end