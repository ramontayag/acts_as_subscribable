$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems' # I think it allows the usage of gems, like active_record, active_support, etc.
require 'active_support' unless defined? ActiveSupport # Need this so that mattr_accessor will work in Subscriber module
# require 'active_record/acts/subscribable'
# require 'active_record/acts/subscriber'
# require 'action_view'
# require 'action_controller' # Since we'll be testing subscriptions controller
# 
require 'active_record' # Since we'll be testing a User model which will be available in the app

ENV['RAILS_ENV'] = 'test'

require 'spec'
require 'spec/autorun'
require 'rails/init'

rails_root = File.dirname(__FILE__) + '/rails_root'
require "#{rails_root}/config/environment.rb"

puts "------------------ #{RAILS_ROOT}"
# Run the migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")

# class ActiveSupport::TestCase #:nodoc:
#   self.use_transactional_fixtures = false
#   self.use_instantiated_fixtures  = false
# end 

# 
# # Tell active record to load the subscribable files
# ActiveRecord::Base.send(:include, ActiveRecord::Acts::Subscribable)
# ActiveRecord::Base.send(:include, ActiveRecord::Acts::Subscriber)
# 
# 
# require 'app/models/user' # The user model we expect in the application
# require 'app/models/person'
# require 'app/models/subscription'
# require 'app/models/dorkus'
# require 'app/controllers/subscriptions_controller' # The controller we're testing
# 
# Setup the user as an emailing subscribing class
ActiveRecord::Acts::Subscriber.emailing_subscriber_classes = [User]
# 
# # Allows loading of schema in the tests we need.
# def load_schema
#   config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
#   ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
# 
#   db_adapter = ENV['DB']
# 
#   # no db passed, try one of these fine config-free DBs before bombing.
#   db_adapter ||=
#     begin
#       require 'rubygems'
#       require 'sqlite'
#       'sqlite'
#     rescue MissingSourceFile
#       begin
#         require 'sqlite3'
# 				puts "tried to load sqlite3"
#         'sqlite3'
#       rescue MissingSourceFile
#       end
#     end
# 
#   if db_adapter.nil?
#     raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."
#   end
# 
#   ActiveRecord::Base.establish_connection(config[db_adapter])
#   load(File.dirname(__FILE__) + "/db/schema.rb")
#   require File.dirname(__FILE__) + '/../rails/init.rb'
# 
# 	# Easily create mock models
# 	require File.expand_path(File.dirname(__FILE__) + "/mock_models")
# end
# 
# Couldn't find a way to do this automatically, so let's do it manually!
def purge_db
	User.delete_all
	Subscription.delete_all
	Dorkus.delete_all
end

Spec::Runner.configure do |config|
  config.before(:each) { purge_db }
end
