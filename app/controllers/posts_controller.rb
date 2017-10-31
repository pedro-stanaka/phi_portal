# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update]

  def index
    @posts = paginate(Post.all, per_page: 5)
  end

  def create
    @post = Post.create! post_params
    render 'posts/show', status: :created
  end

  def show
    render 'posts/show', status: :ok
  end

  def update
    @post.update!(post_params)

    render 'posts/show', status: :ok
  end

private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.permit(
      :title,
      :body
    )
  end
end
