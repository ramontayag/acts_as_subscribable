require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# require 'subscriptions_controller'
# require 'active_support/test_case'
# require 'action_controller/test_case'

describe SubscriptionsController, "on GET index" do
	# load_schema      
  def setup
    @controller = SubscriptionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @post       = Subscription.first
  end     

	before do
		setup
	end

	describe ", when only subscribable params are passed" do
		it "should list all the subscriptions of the subscribable object"
	end

	describe ", when only subscriber params are passed" do
		it "should list all the subscriptions of the subscriber" do
			u = User.create
			d1 = Dorkus.create
			d2 = Dorkus.create
			d1.subscribe! u
			d2.subscribe! u

			get :index, {:subscriber_type => "User", :subscriber_id => u.id}
			assigns[:subscriptions].should == u.subscriptions
		end
	end
end
