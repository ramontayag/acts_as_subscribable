class Subscription < ActiveRecord::Base
	belongs_to :subscriber, :polymorphic => true
	#belongs_to :subscribable, :polymorphic => true
	validates_presence_of :subscriber_id, :unless => Proc.new {|m| m.email}
	validates_presence_of :subscriber_type, :unless => Proc.new {|m| m.email}
	validates_presence_of :email, :unless => Proc.new {|m| m.subscriber_type && m.subscriber_id}
  validates_length_of :email, :within => 6..100, :unless => Proc.new {|m| m.email.blank?}
  validates_format_of :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i  
	validates_uniqueness_of :subscriber_id, :scope => [:subscriber_type, :subscribable_type, :subscribable_id], :if => Proc.new {|m| !m.email}
	validates_uniqueness_of :email, :scope => [:subscribable_id, :subscribable_type]
	after_create :process_subscribers

	private

	def process_subscribers
		ActiveRecord::Acts::Subscriber.emailing_subscriber_classes.each do |klass|
			email_column = klass.email_column
			
			if klass.columns_hash.has_key?(email_column.to_s)
				subscriber = klass.find(:first, :conditions => {email_column => self.email})

				if subscriber
					self.subscriber = subscriber
					self.email = nil
					self.save
				end
			end

		end
	end
end
