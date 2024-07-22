require 'stripe'
module TagoStripe
    class Price
        def initialize
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            prices = Stripe::Price.list()
            return prices.data
        end

        def self.activeList
            prices = Stripe::Price.list({active: true})
            return prices.data
        end

        def self.getOne(price_id)
            price = Stripe::Price.retrieve(price_id)
            return price
        end

        def self.create(product_id, unit_amount, currency, recurring_interval, recurring_interval_count)
            price = Stripe::Price.create({
                product: product_id,
                unit_amount: unit_amount,
                currency: currency,
                recurring: {
                    interval: recurring_interval,
                    interval_count: recurring_interval_count
                }
            })
            return price
        end

        def self.update(price_id, unit_amount, currency, recurring_interval, recurring_interval_count)
            price = Stripe::Price.update(price_id, {
                unit_amount: unit_amount,
                currency: currency,
                recurring: {
                    interval: recurring_interval,
                    interval_count: recurring_interval_count
                }
            })
            return price
        end

        def self.delete(price_id)
            price = Stripe::Price.delete(price_id)
            return price
        end

    end
end