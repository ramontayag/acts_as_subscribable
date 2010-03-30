require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dorkus do
	# load_schema

	before do
		@dorkus = Dorkus.create!
	end

	it "should not allow the same email to subscribe more than once to a particular subscribable model" do
		@dorkus.subscribe!("hi@email.com")
		@dorkus.subscribe!("hi@email.com")
		@dorkus.subscriptions.count.should == 1
	end

  describe ".subscriptions" do
		before do
			@user = User.create!
		end

		it "should return all the subscriptions" do
			@dorkus.subscribe!(@user)
			@dorkus.subscriptions.count.should == 1
		end
	end

	describe ".subscribe!" do
		describe "if a user is passed" do    
			before do
				@user = User.create!
			end
           
			it "should subscribe the user passed" do
				Subscription.should_receive(:create).with(:subscribable_type => "Dorkus", :subscribable_id => @dorkus.id, :subscriber_id => @user.id, :subscriber_type => @user.class.name)
				@dorkus.subscribe!(@user)
			end
		end

		describe "if a string is passed" do
			it "should save it as an email" do
				@dorkus.subscribe!("ramon@email.com")
				Subscription.exists?(:email => "ramon@email.com").should be_true
			end
		end
	end

	describe ".subscribers" do
		it "should return the subscribers" do
			user = User.create
			@dorkus.subscribe!(user)
			@dorkus.subscribers.should == [user]
		end
	end          
end
