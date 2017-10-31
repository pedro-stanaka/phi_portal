# frozen_string_literal: true

Rails.application.routes.draw do
  get 'posts/create'

  resources :posts
end
