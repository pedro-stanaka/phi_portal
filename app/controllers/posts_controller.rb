class PostsController < ApplicationController
  def index
    @posts = paginate(Post.all, per_page: 5)
  end

  def create
    @post = Post.create! post_params
    render 'show.json', status: 201
  end

private

  def post_params
    params.permit(
      :title,
      :body
    )
  end
end
