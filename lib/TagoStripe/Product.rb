require 'stripe'
module TagoStripe
    class Product
        def initialize
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            products = Stripe::Product.list()
            return products.data
        end

        def self.activeList 
            products = Stripe::Product.list({active: true})
            return products.data
        end

        def self.getOne(product_id)
            product = Stripe::Product.retrieve(product_id)
            return product
        end

        def self.create(name, description, unit_label)
            product = Stripe::Product.create({
                name: name,
                description: description,
                unit_label: unit_label
            })
            return product
        end

        def self.update(product_id, name, description, unit_label)
            product = Stripe::Product.update(product_id, {
                name: name,
                description: description,
                unit_label: unit_label
            })
            return product
        end

        def self.delete(product_id)
            product = Stripe::Product.delete(product_id)
            return product
        end
    end
    
end
