class CommentsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to root_path, :alert => exception.message
    end
  end

  def report
    if user_signed_in?
      comment = Comment.find(params[:id])
      current_user.flag(comment, :abuse) 
      comment.update_attributes(:flagged => true)
      redirect_to :back, notice: "Comment has been reported"
    else
      redirect_to :back, alert: "You must be logged in to report comments"
    end
  end

  def flagged
    @comments = Comment.where(:flagged => true).page(params[:page])
    render :index
  end

  def destroy
    Comment.find(params[:id]).destroy
    respond_to do |format| 
      format.html { redirect_to :back } 
      format.json { head :no_content } 
    end 
  end 

end
