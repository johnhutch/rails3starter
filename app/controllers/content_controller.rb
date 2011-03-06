class ContentController < ApplicationController
  
  def front
  end
  
  def contact
  end
  
  def admin
    @posts = Post.all
  end
  
end
