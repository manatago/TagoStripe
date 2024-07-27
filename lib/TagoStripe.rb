# frozen_string_literal: true

require_relative "TagoStripe/version"
require_relative "TagoStripe/Product"
require_relative "TagoStripe/Price"
require_relative "TagoStripe/Customer"
require_relative "TagoStripe/Common"
require_relative "TagoStripe/Subscription"
require_relative "TagoStripe/PaymentLink"


module TagoStripe
  class Error < StandardError; end

  class << self
    def initialize
      puts "hello"
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    end

    def list
      puts "hello"
    end
  end
  # Your code goes here...
end
