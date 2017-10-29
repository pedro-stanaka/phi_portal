class PostsController < ApplicationController
  def index
    @posts = paginate(Post.all, per_page: 5)
  end
end
