# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do

  let(:headers) { {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
  }}

  describe 'GET /posts' do
    before do
      6.times do
        post = Post.new
        post.title = Faker::Name.first_name
        post.body = Faker::Lorem.words(5)
        post.save
      end
    end

    before { get '/posts', headers: headers }

    it 'returns a list of posts' do
      expect(json['data']).to be_an_instance_of Array
    end

    it 'paginates the content' do
      expect(json['data'].size).to equal(5)
      expect(response.headers['Per-Page']).to eq('5')
      expect(response.headers['Total']).to eq('6')
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

  describe 'GET /posts/:id' do
    context 'when post exists' do
      let(:post) { create(:post) }
      before { get "/posts/#{post.id}", headers: headers }

      it 'returns a ok code' do
        expect(response).to have_http_status(:ok)
      end

      it 'return a post in the body of the response' do
        expect(json['title']).to eq(post.title)
      end
    end

    context 'when post does not exist' do
      before { get '/posts/1', headers: headers }

      it 'should return an error message' do
        expect(json['message']).to match(/Couldn't find Post with 'id'=1/)
      end
    end
  end

  describe 'PUT /posts/:id' do
    context 'when post exists' do
      let(:post) { create(:post) }
      before do
        post.title = 'New title'
        put "/posts/#{post.id}", params: post.to_json, headers: headers
      end

      it 'should return a post with modified attributes' do
        expect(json['title']).to match(/New title/)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    context 'when post exists' do
      let(:post) { create(:post) }
      before do
        delete "/posts/#{post.id}", headers: headers
      end

      it 'should delete a post and return a success message' do
        expect(json['message']).to eq(I18n.t('posts.deleted'))
      end
    end
  end
end
