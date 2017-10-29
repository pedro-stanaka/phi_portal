class PostsController < ApplicationController
  def index
    puts "Test"
    @posts = Post.all
  end
end
