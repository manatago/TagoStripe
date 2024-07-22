require 'stripe'
module TagoStripe
    class Product
        def set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            set_api_key
            products = Stripe::Product.list()
            return products.data
        end

        def self.activeList
            set_api_key
            products = Stripe::Product.list({active: true})
            return products.data
        end

        def self.getOne(product_id)
            set_api_key
            product = Stripe::Product.retrieve(product_id)
            return product
        end

        def self.create(name, description, unit_label)
            set_api_key
            product = Stripe::Product.create({
                name: name,
                description: description,
                unit_label: unit_label
            })
            return product
        end

        def self.update(product_id, name, description, unit_label)
            set_api_key
            product = Stripe::Product.update(product_id, {
                name: name,
                description: description,
                unit_label: unit_label
            })
            return product
        end

        def self.delete(product_id)
            set_api_key
            product = Stripe::Product.delete(product_id)
            return product
        end
    end
    
end
