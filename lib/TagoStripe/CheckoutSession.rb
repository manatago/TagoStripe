require 'stripe'
module TagoStripe
    class CheckoutSession
        def set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            set_api_key
            checkout_sessions = Stripe::Checkout::Session.list()
            return checkout_sessions.data
        end

        def self.getOne(checkout_session_id)
            set_api_key
            checkout_session = Stripe::Checkout::Session.retrieve(checkout_session_id)
            return checkout_session
        end

        def self.create(customer_id, success_url, cancel_url, payment_method_types, line_items)
            set_api_key
            checkout_session = Stripe::Checkout::Session.create({
                customer: customer_id,
                success_url: success_url,
                cancel_url: cancel_url,
                payment_method_types: payment_method_types,
                line_items: line_items
            })
            return checkout_session
        end

        def self.update(checkout_session_id, customer_id, success_url, cancel_url, payment_method_types, line_items)
            set_api_key
            checkout_session = Stripe::Checkout::Session.update(checkout_session_id, {
                customer: customer_id,
                success_url: success_url,
                cancel_url: cancel_url,
                payment_method_types: payment_method_types,
                line_items: line_items
            })
            return checkout_session
        end

        def self.delete(checkout_session_id)
            set_api_key
            checkout_session = Stripe::Checkout::Session.delete(checkout_session_id)
            return checkout_session
        end

        def self.listByCustomer(customer_id)
            set_api_key
            checkout_sessions = Stripe::Checkout::Session.list({customer: customer_id})
            return checkout_sessions.data
        end
    end
end