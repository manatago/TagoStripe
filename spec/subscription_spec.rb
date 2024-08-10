require 'spec_helper'
require 'TagoStripe'


RSpec.describe 'Subscription' do
    #適当なユーザーを作るときは
    #emailがst@stago.com
    #nameがstago
    #metadataが{key: "value",key2: "value2"}とする

    #サブスクの一覧を取得できる
    it 'get subscription list' do
        subscriptions = TagoStripe::Subscription.list()
        #subscriptions.first.idが１０文字以上である
        expect(subscriptions.first.id.length).to be > 10
    end

    #適当な顧客を作る
    #アクティブな製品と価格の一覧を取得する
    #その中でサブスクリプションの価格IDを取得する
    #その顧客、価格IDでサブスクリプションを作成する
    #作成したサブスクリプションのIDが１０文字以上である
    it 'create subscription' do
        customer = TagoStripe::Customer.create("st@stago.com","stago",{key: "value",key2: "value2"})
        payment_method = Stripe::PaymentMethod.attach(
            'pm_card_visa',
            {customer: customer.id}
        )
        Stripe::Customer.update(
            customer.id,
            invoice_settings: {
                default_payment_method: payment_method.id
            }
        )
        #products = TagoStripe::Product.activeList()
        prices = TagoStripe::Price.activeList()

        price_id =''
        prices.each do |price|
            #product_idを取得
            product = TagoStripe::Product.getOne(price.product)
            #productがactiveであればループを抜ける
            if product.active
                price_id = price.id
                break
            end
        end

        
        subscription = TagoStripe::Subscription.create(customer.id,price_id)
        expect(subscription.id.length).to be > 10


        #activeListByCustomerで顧客のサブスクリプションを取得できる
        subscriptions = TagoStripe::Subscription.listByCustomer(customer.id)
        expect(subscriptions.first.id).to eq(subscription.id)


        #このサブスクリプションをキャンセルすることも確認
        subscription = TagoStripe::Subscription.cancel(subscription.id)
        expect(subscription.status).to eq("canceled")
    end
  

end