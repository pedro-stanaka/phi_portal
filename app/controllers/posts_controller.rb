# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :destroy]

  def index
    @posts = paginate(Post.all, per_page: 5)
  end

  def create
    @post = Post.create! post_params
    render 'posts/show', status: :created
  end

  def show
  end

  def update
    @post.update!(post_params)

    render 'posts/show', status: :ok
  end

  def destroy
    @post.destroy!

    render json: { message: I18n.t('posts.deleted') }
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
