require 'spec_helper'

describe "Create payment on successful charge" do
	let(:event_data) do
		event_data = {
			  "id" => "evt_3xNWVLXJlxP6ZO",
			  "created" => 1398983708,
			  "livemode" => false,
			  "type" => "customer.subscription.created",
			  "data" => {
			    "object" => {
			      "id" => "sub_3xNWySAVqIIahA",
			      "plan" => {
			        "interval" => "month",
			        "name" => "Base Plan",
			        "created" => 1398924680,
			        "amount" => 999,
			        "currency" => "usd",
			        "id" => "1",
			        "object" => "plan",
			        "livemode" => false,
			        "interval_count" => 1,
			        "trial_period_days" => 7,
			        "metadata" => {},
			        "statement_description" => "MyFlix Plan"
			      },
			      "object" => "subscription",
			      "start" => 1398983708,
			      "status" => "trialing",
			      "customer" => "cus_3xNWqQ1nGF1d6f",
			      "cancel_at_period_end" => false,
			      "current_period_start" => 1398983708,
			      "current_period_end" => 1399588508,
			      "ended_at" => nil,
			      "trial_start" => 1398983708,
			      "trial_end" => 1399588508,
			      "canceled_at" => nil,
			      "quantity" => 1,
			      "application_fee_percent" => nil,
			      "discount" => nil
			    }
			  },
			  "object" => "event",
			  "pending_webhooks" => 1,
			  "request" => "iar_3xNWBTGfqmD3ZK"
			}
		end

	it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
		post "/strip_events", event_data
		expect(Payment.count).to eq(1)
	end

	it "creates the payment associated with user", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3xNWqQ1nGF1d6f")
		post "/stripe_events", event_data
		expect(Payment.first.user).to eq(alice)
	end

	it "creates the payment with the amount", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3xNWqQ1nGF1d6f")
		post "/stripe_events", event_data
		expect(Payment.first.amount).to eq(999)		
	end

	it "creates the payment with reference id", :vcr do
		alice = Fabricate(:user, customer_token: "cus_3xNWqQ1nGF1d6f")
		post "/stripe_events", event_data
		expect(Payment.first.reference_id).to eq("sub_3xNWySAVqIIahA")	
	end

	
end