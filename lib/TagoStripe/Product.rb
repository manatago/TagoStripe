require 'stripe'
module TagoStripe
    class Product
        def getList
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
            products = Stripe::Product.list()
        end
    end
    
end
