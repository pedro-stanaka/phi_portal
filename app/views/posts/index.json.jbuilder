# frozen_string_literal: true

json.data do
  json.array! @posts, partial: 'posts/post', as: :post
end
