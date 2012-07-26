class CommentsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_parent, :only => [:create]
  
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def create
    @comment = @parent.comments.create(params[:comment])
    @comment.user_id = current_user.id
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = t('flash.comment_created')
        format.xml  { head :ok }
      else
        flash[:notice] = t('flash.comment_problem')
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
      format.html {redirect_to :controller => @parent.class.to_s.pluralize.underscore, :action => :show, :id => @parent.id}
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    @parent = @comment.parent

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = t('flash.comment_updated')
        format.xml  { head :ok }
      else
        flash[:notice] = t('flash.comment_problem')
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
      format.html {redirect_to :controller => @parent.class.to_s.pluralize.underscore, :action => :show, :id => @parent.id}
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @parent = @comment.parent
    @comment.destroy

    respond_to do |format|
      format.html {redirect_to :controller => @parent.class.to_s.pluralize.underscore, :action => :show, :id => @parent.id}
      format.xml  { head :ok }
    end
  end

  private

  def find_parent
    @klass = @klass
    @klass = params[:parent_type].camelize.constantize
    @parent = @klass.find(params[:parent_id])
  end
end
