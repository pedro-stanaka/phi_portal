# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do

  let(:headers) { {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
  } }

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

  describe 'POST /posts' do
    context 'when passed invalid data' do
      let(:invalid) { { title: 'Some title' } }

      before { post '/posts', params: invalid.to_json, headers: headers }

      it 'throw an error with 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['message']).to match(/Body can't be blank/)
      end
    end

    context 'when passed valid data' do
      let(:valid) { build(:post) }

      before { post '/posts', params: valid.to_json, headers: headers }

      it 'return a 201' do
        expect(response).to have_http_status(:created)
        expect(json['title']).to match(/A New Post/)
      end
    end
  end
end
