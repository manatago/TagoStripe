require 'stripe'
module TagoStripe
    class Customer
        def self.set_api_key
            Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        end

        def self.list
            set_api_key
            customers = Stripe::Customer.list()
            return customers.data
        end

        def self.getOne(customer_id)
            set_api_key
            customer = Stripe::Customer.retrieve(customer_id)
            return customer
        end

        #顧客名を部分一致で検索できる
        def self.searchByName(name)
            set_api_key
            customers = Stripe::Customer.list
            customers.select { |customer| customer.name.include?(name) }
        end

        #emailを部分一致で検索できる
        def self.searchByEmail(email)
            set_api_key
            customers = Stripe::Customer.list
            customers.select { |customer| customer.email.include?(email) }
        end

        def self.create(email, name , metaData={})
            set_api_key
            customer = Stripe::Customer.create({
                email: email,
                name: name,
                metadata: metaData
            })
            return customer
        end

        def self.update(customer_id, name, email, metaData={})
            set_api_key
            customer = Stripe::Customer.update(customer_id, {
                email: email,
                name: name,
                metadata: metaData
            })
            return customer
        end

        def self.delete(customer_id)
            set_api_key
            customer = Stripe::Customer.delete(customer_id)
            return customer
        end

        def self.createCustomerSession(customer_id)
            set_api_key
            Stripe::CustomerSession.create({
                customer: customer_id,
                components: {buy_button: {enabled: true}},
            })
        end

    end
end
