require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def valid_attributes
	@valid_attributes = {
		:email => "some@crap-mail.com",
		:subscribable_type => "Dorkus",
		:subscribable_id => 1,
		:subscriber_id => 1,
		:subscriber_type => "User"
	}
end

describe Subscription do
	# load_schema

	it "should belong_to user" do
		u = User.create!
		attributes = valid_attributes.except(:email)
		attributes[:subscriber_id] = u.id
		attributes[:subscriber_type] = u.class.name
		s = Subscription.create!(attributes)
		s.subscriber.should == u
	end

	describe "when there's email" do
		it "should not require subscriber_type and subscriber_id" do
			s = Subscription.new(valid_attributes.except(:subscriber_type, :subscriber_id))
			s.should be_valid
		end
	end

	describe "when there's a subscriber" do
		it "should not require email" do
			s = Subscription.new(valid_attributes.except(:email))
			s.should be_valid
		end
	end

	it "should require subscriber and email" do
		s = Subscription.new(valid_attributes.except(:email, :subscriber_id, :subscriber_type))
		#s.should have(1).error_on(:user_id) # error_on should work but I'm getting an undefined method
		s.valid?
		s.errors.each { |e| puts e}
		s.should have(3).errors
	end

	it "should reject invalid emails" do
		s = Subscription.new(valid_attributes.except(:email, :subscriber_id, :subscriber_type))
		s.email = "dork@us89/&@domain.com"
		s.should_not be_valid
	end
		
	it "should accept valid emails" do      
		s = Subscription.new(valid_attributes.except(:email, :subscriber_id, :subscriber_type))
		s.email = "dorkus89@domain.com"
		s.should be_valid     
	end

	describe "after creation" do
		it "should assign itself to a user if a user exists with that email" do
			user = User.create!(:email => "eemail@gmail.com")
			attributes = valid_attributes
			attributes[:email] = "eemail@gmail.com"
			s = Subscription.create!(attributes)
			s.subscriber.should == user
			s.email.should be_nil
		end
	end
end
