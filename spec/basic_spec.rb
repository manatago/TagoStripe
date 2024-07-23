# spec/sample_spec.rb
require 'spec_helper'
require 'TagoStripe'


RSpec.describe 'Basic' do
  #環境変数にSTRIPE_SECRET＿KEYが存在し、１０文字以上である
  it 'has a stripe secret key' do
    expect(ENV['STRIPE_SECRET_KEY']).not_to be_nil
    expect(ENV['STRIPE_SECRET_KEY'].length).to be > 10
  end

  #TagoStripe::VERSIONが存在する
  it 'has a version number' do
    expect(TagoStripe::VERSION).not_to be nil
  end


end