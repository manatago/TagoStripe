require 'stripe'
module TagoStripe
    class PaymentLink
        def self.set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            set_api_key
            payment_links = Stripe::PaymentLink.list()
            return payment_links.data
        end

        def self.getOne(payment_link_id)
            set_api_key
            payment_link = Stripe::PaymentLink.retrieve(payment_link_id)
            return payment_link
        end

        def self.create(price_id)
            set_api_key
            payment_link = Stripe::PaymentLink.create({
            line_items: [
                    {
                        price: price_id,
                        quantity: 1,
                    },
                ],
            })
            return payment_link
        end

        def self.update(payment_link_id, amount, currency, description, payment_method_types)
            set_api_key
            payment_link = Stripe::PaymentLink.update(payment_link_id, {
                amount: amount,
                currency: currency,
                description: description,
                payment_method_types: payment_method_types
            })
            return payment_link
        end

        def self.delete(payment_link_id)
            set_api_key
            payment_link = Stripe::PaymentLink.delete(payment_link_id)
            return payment_link
        end
    
    end
end