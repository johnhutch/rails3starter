class CommentsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_parent
  
  def create
    @comment = @parent.comments.create(params[:comment])
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = "Comment posted successfully."
      else
        flash[:notice] = "There was a problem saving your comment."
      end
      format.html {redirect_to :controller => @parent.class.to_s.pluralize.underscore, :action => :show, :id => @parent.id}
    end
  end

  private

  def find_parent
    @klass = @klass
    @klass = params[:parent_type].camelize.constantize
    @parent = @klass.find(params[:parent_id])
  end
end
