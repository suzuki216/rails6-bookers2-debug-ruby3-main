class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book = @book

    if @comment.save
      redirect_back fallback_location: book_path(@book), notice: "コメントを投稿しました"
    else
      redirect_back fallback_location: book_path(@book), alert: "コメントを入力してください"
    end
  end

  def destroy
    @comment = BookComment.find(params[:id])
    book = @comment.book
    @comment.destroy
    redirect_back fallback_location: book_path(book), notice: "コメントを削除しました"
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    @comment = current_user.book_comments.find_by(id: params[:id])
    redirect_back fallback_location: root_path, alert: "権限がありません" if @comment.nil?
  end
end

