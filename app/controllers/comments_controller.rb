class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      #通知機能
      @tweet = @comment.tweet
      @tweet.create_notification_comment!(current_user, @comment.id)
      #ここまで
      redirect_back(fallback_location: tweets_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: tweets_path)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = '投稿へのコメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:comment)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      unless @comment
        redirect_to root_url
      end
    end

end
