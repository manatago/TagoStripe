require 'stripe'
module TagoStripe
    class Common
        def self.api_key
            ENV['STRIPE_SECRET_KEY']
        end

        def self.hello
            "hello world"
        end
    end
end