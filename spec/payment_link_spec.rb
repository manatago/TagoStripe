# spec/sample_spec.rb
require 'spec_helper'
require 'TagoStripe'


RSpec.describe 'PaymentLink' do

    #TagoStripe::Product.list.first.nameが５文字以上で定義されている
    it '支払いリンクリスト取得がちゃんとできる' do
        expect(TagoStripe::PaymentLink.list.length).to be > 1
    end

    it 'アクティブな支払いリンクリスト取得がちゃんとできる' do
        expect(TagoStripe::PaymentLink.activeList.length).to be > 1
    end

    it '支払いリンクIDを指定してgetOneが動く' do
        payment_link_id = TagoStripe::PaymentLink.list.first.id
        expect(TagoStripe::PaymentLink.getOne(payment_link_id).id).to eq(payment_link_id)
    end

    it '支払いリンクIDを指定してgetOneWithPriceが動く' do
        payment_link_id = TagoStripe::PaymentLink.list.first.id
        payment_link = TagoStripe::PaymentLink.getOneWithPrice(payment_link_id)
        expect(TagoStripe::Price.list.map(&:id).include?(payment_link.price.id)).to eq(true)
    end

end
