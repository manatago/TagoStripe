require 'stripe'
module TagoStripe
    class Subscription
        def self.set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            set_api_key
            subscriptions = Stripe::Subscription.list()
            return subscriptions.data
        end

        def self.activeList
            set_api_key
            subscriptions = Stripe::Subscription.list({status: 'active'})
            return subscriptions.data
        end

        def self.getOne(subscription_id)
            set_api_key
            subscription = Stripe::Subscription.retrieve(subscription_id)
            return subscription
        end

        def self.create(customer_id, price_id)
            set_api_key
            subscription = Stripe::Subscription.create({
                customer: customer_id,
                items: [{price: price_id}]
            })
            return subscription
        end

        def self.update(subscription_id, price_id)
            set_api_key
            subscription = Stripe::Subscription.update(subscription_id, {
                items: [{price: price_id}]
            })
            return subscription
        end

        def self.cancel(subscription_id)
            set_api_key
            subscription = Stripe::Subscription.delete(subscription_id)
            return subscription
        end

        def self.listByCustomer(customer_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({customer: customer_id})
            return subscriptions.data
        end

        def self.listByPrice(price_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({price: price_id})
            return subscriptions.data
        end

        def self.listByProduct(product_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({product: product_id})
            return subscriptions.data
        end

        def activeListByCustomer(customer_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({customer: customer_id, status: 'active'})
            return subscriptions.data
        end

        def activeListByPrice(price_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({price: price_id, status: 'active'})
            return subscriptions.data
        end

        def activeListByProduct(product_id)
            set_api_key
            subscriptions = Stripe::Subscription.list({product: product_id, status: 'active'})
            return subscriptions.data
        end

        
    end
end
