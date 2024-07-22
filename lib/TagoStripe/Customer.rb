require 'stripe'
module TagoStripe
    class Customer
        def initialize
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            customers = Stripe::Customer.list()
            return customers.data
        end

        def self.getOne(customer_id)
            customer = Stripe::Customer.retrieve(customer_id)
            return customer
        end

        def self.create(email, name , metaData={})
            customer = Stripe::Customer.create({
                email: email,
                name: name,
                metadata: metaData
            })
            return customer
        end

        def self.update(customer_id, email, name, metaData={})
            customer = Stripe::Customer.update(customer_id, {
                email: email,
                name: name,
                metadata: metaData
            })
            return customer
        end

        def self.delete(customer_id)
            customer = Stripe::Customer.delete(customer_id)
            return customer
        end

    end
end
