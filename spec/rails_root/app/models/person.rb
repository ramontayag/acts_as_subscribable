class Person < ActiveRecord::Base
	acts_as_subscriber :email_column => "my_own_email_column"
end
