require 'stripe'
module TagoStripe
    class Product


        def self.set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
            @isTest = true
        end

        def self.list
            set_api_key
            p self.superclass.name
            products = Stripe::Product.list()
            return products.data
        end

        def self.activeList
            set_api_key
            products = Stripe::Product.list({active: true})
            return products.data
        end

        def self.activeListWithPrice
            set_api_key
            products = Stripe::Product.list({active: true})
            products.data.each do |product|
                prices = Stripe::Price.list({product: product.id,active: true})
                product.prices = prices.data
            end
            return products.data
        end

        #製品名で検索(部分一致)
        def self.searchByName(name)
            set_api_key
            products = Stripe::Product.list
            products.select { |product| product.name.include?(name) }
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
