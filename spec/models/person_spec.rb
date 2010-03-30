require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do
	# load_schema

	it "should be able to assign the email field is" do
		Person.email_column == "my_own_email_column"
	end
end
