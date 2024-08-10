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

        def self.activeList
            set_api_key
            payment_links = Stripe::PaymentLink.list({active: true})
            return payment_links.data
        end


        def self.getOne(payment_link_id)
            set_api_key
            payment_link = Stripe::PaymentLink.retrieve(payment_link_id)
            return payment_link
        end

        def self.getOneWithPrice(payment_link_id)
            set_api_key
            payment_link = Stripe::PaymentLink.retrieve(payment_link_id)
            payment_link_line_items = Stripe::PaymentLink.list_line_items(payment_link_id)
            payment_link.price = payment_link_line_items.data[0].price
            return payment_link
        end


        def self.getOneWithPriceAndProduct(payment_link_id)
            set_api_key
            payment_link = Stripe::PaymentLink.retrieve(payment_link_id)
            payment_link_line_items = Stripe::PaymentLink.list_line_items(payment_link_id)
            payment_link.price = payment_link_line_items.data[0].price
            product = Stripe::Product.retrieve(payment_link.price.product)
            payment_link.product = product
            payment_link
        end

        def self.listWithPriceAndProduct()
            set_api_key
            payment_links = Stripe::PaymentLink.list()
            result=[]
            payment_links.data.each do |payment_link|
                result.push(getOneWithPriceAndProduct(payment_link.id))
            end
            return result
        end



        def self.list_line_items(payment_link_id)
            set_api_key
            payment_link_line_items = Stripe::PaymentLink.list_line_items(payment_link_id)
            return payment_link_line_items.data
        end

        def self.list_line_items_by_payment_link(payment_link)
            set_api_key
            payment_link_line_items = Stripe::PaymentLink.list_line_items(payment_link.id)
            return payment_link_line_items.data
        end

        def self.create(amount, currency, description, payment_method_types)
            set_api_key
            payment_link = Stripe::PaymentLink.create({
                amount: amount,
                currency: currency,
                description: description,
                payment_method_types: payment_method_types
            })
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