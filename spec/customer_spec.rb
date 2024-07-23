# spec/sample_spec.rb
require 'spec_helper'
require 'TagoStripe'


RSpec.describe 'Customer' do
    #適当なユーザーを作るときは
    #emailがst@stago.com
    #nameがstago
    #metadataが{key: "value",key2: "value2"}とする


    #顧客一覧を取得できる
    it 'get customer list' do
        customers = TagoStripe::Customer.list()
        expect(customers.length).to be >  3
    end

    #顧客を作成できる
    it 'create customer' do
        customer = TagoStripe::Customer.create("st@stago.com", "stago", {key: "value",key2: "value2"})
        expect(customer.email).to eq "st@stago.com"
        expect(customer.name).to eq "stago"
        expect(customer.metadata.key).to eq "value"
        expect(customer.metadata.key2).to eq "value2"
    end

    #この時点でstagoさんが入っているのを前提にする
    #stagoの名前で検索できる
    it 'search by name' do
        customers = TagoStripe::Customer.searchByName("stago")
        expect(customers.length).to be > 0
    end

   
    #emailで検索できる
    it 'search by email' do
        customers = TagoStripe::Customer.searchByEmail("st@stago.com")
        expect(customers.length).to be > 0
    end

    #emailの部分一致でも検索できる
    it 'search by email' do
        customers = TagoStripe::Customer.searchByEmail("st@")
        expect(customers.length).to be > 0
    end

    #stagoさんの情報を変更できる
    it 'update stago' do
        customers = TagoStripe::Customer.searchByName("stago")
        customer_id = customers.first.id
        customer = TagoStripe::Customer.update(customer_id, "stago2","st2@stago.com", {key: "value2",key2: "value3"})
        expect(customer.name).to eq "stago2"
        expect(customer.email).to eq "st2@stago.com"
        expect(customer.metadata.key).to eq "value2"
        expect(customer.metadata.key2).to eq "value3"
        #最後にstagoさんに戻しておく
        customer = TagoStripe::Customer.update(customer_id, "stago","st@stago.com", {key: "value",key2: "value2"})
    end
    

    #customerSessionを取得できる
    it 'create customer session' do
        customers = TagoStripe::Customer.searchByName("stago")
        customer_id = customers.first.id
        session = TagoStripe::Customer.createCustomerSession(customer_id)
        expect(session.customer).to eq customer_id
        #client_secrteが３０文字以上である
        expect(session.client_secret.length).to be > 30
    end



    #stagoさんだらけになるので、全部削除する
    it 'delete all stago' do
        customers = TagoStripe::Customer.searchByName("stago")
        customers.each do |c|
            TagoStripe::Customer.delete(c.id)
        end
        customers = TagoStripe::Customer.searchByName("stago")
        expect(customers).to eq([])
    end



end