class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book = book
    @comment.save
  end

  def destroy

    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    if @comment
      @comment.destroy
      respond_to do |format|
        format.js  # destroy.js.erbを返す
      end
    else
      respond_to do |format|
        format.js { render js: "" }
      end
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

