class CommentsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
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

end
