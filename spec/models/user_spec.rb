require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
	# load_schema

	it "should load properly" do
		User.new.should be_kind_of(User)
	end

	it "should assign the default email field" do
		User.email_column == "email"
	end

	describe "after creation" do
		it "should process_subscriptions" do
			u = User.new :email => "justcreated@email.com"
			u.should_receive(:process_subscriptions).once
			u.save
		end
	end

	describe "before updating the email record" do
		# Why before updating? Because that's when we can test for dirty attributes - see if the email_changed?
		it "should process_subscriptions" do
			u = User.create
			u.email = "mynew@email.com"
			u.should_receive(:process_subscriptions).once
			u.save
		end
	end
	
	describe ".process_subscriptions" do
		it "should search all subscriptions that match the email and assign it to itself" do
			d1 = Dorkus.create
			d2 = Dorkus.create
			d1.subscribe!("first@email.com")

			u = User.create :email => "first@email.com"
			u2 = User.create :email => "loser@email.com"

			u.subscriptions.count.should == 1
		end
	end
end
