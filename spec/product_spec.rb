# spec/sample_spec.rb
require 'spec_helper'
require 'TagoStripe'


RSpec.describe 'Product' do

    #TagoStripe::Product.list.first.nameが５文字以上で定義されている
    it '製品リスト取得がちゃんとできる' do
        expect(TagoStripe::Product.list.first.name.length).to be > 5
    end

    #TagoStripe::Product.createがちゃんとできる
    it '製品作成がちゃんとできる' do
        product = TagoStripe::Product.create("test_product", "test_description", "test_unit")
        expect(product.name).to eq("test_product")
    end

    #製品名で検索ができる
    it '製品名で検索ができる' do
        product = TagoStripe::Product.searchByName("test_product")
        expect(product.first.name).to eq("test_product")
    end

    #test_productの製品情報が取得できる
    it 'test_productの製品情報が取得できる' do
        product = TagoStripe::Product.searchByName("test_product")
        product_id = product.first.id
        product = TagoStripe::Product.getOne(product_id)
        expect(product.name).to eq("test_product")
    end

    #製品情報の更新ができる
    it '製品情報の更新ができる' do
        product = TagoStripe::Product.searchByName("test_product")
        product_id = product.first.id
        product = TagoStripe::Product.update(product_id, "test_product2", "test_description2", "test_unit2")
        expect(product.name).to eq("test_product2")
        expect(product.description).to eq("test_description2")
        expect(product.unit_label).to eq("test_unit2")
        #最後にこの製品の名前をtest_productに戻しておく
        product = TagoStripe::Product.update(product_id, "test_product", "test_description", "test_unit")

    end


    #アクティブな製品とそれに付随する価格の一覧を取得できる
    it 'アクティブな製品とそれに付随する価格の一覧を取得できる' do
        products = TagoStripe::Product.activeListWithPrice
        products.each do |product|
            expect(product.active).to eq(true)
            product.prices.each do |price|
                expect(price.active).to eq(true)
            end
        end
    end

    ##製品の削除ができる
    it '製品の削除ができる' do
        #test_productがいくつもできている可能性があるので、全部削除する
        product = TagoStripe::Product.searchByName("test_product")
        product.each do |p|
            TagoStripe::Product.delete(p.id)
        end
        #test_productがなくなっていることの確認
        product = TagoStripe::Product.searchByName("test_product")
        expect(product).to eq([])
    end

    ## シークレットキーが設定されている
    it 'シークレットキーが設定されている' do
        # p @isTest
        expect(ENV["STRIPE_SECRET_KEY"]).not_to eq(nil)
    end

end