class PostCommentsController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    post_comment = PostComment.new(post_comment_params)
    post_comment.user_id = current_user.id
    post_comment.book_id = book.id
    post_comment.save
    redirect_to book_path(post_comment.book_id)
    logger.debug post_comment.errors.inspect
  end
  
  def destroy
    PostComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(params[:book_id])
  end
  
  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end