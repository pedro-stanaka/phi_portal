require 'rails_helper'

RSpec.describe 'Posts', type: :request do

  let(:headers) { {'Accept': 'application/json'} }

  describe 'GET /posts' do
    before do
      6.times do
        post = Post.new
        post.title = Faker::Name.first_name
        post.body = Faker::Lorem.words(5)
        post.save
      end
    end

    it 'returns a list of posts' do
      get '/posts', headers: headers

      expect(json['data'].size).to equal 5
    end
  end
end
