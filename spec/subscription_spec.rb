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
  

end