class TweetsController < ApplicationController

  before_action :authenticate_user!

  #投稿一覧
  def index
    @tweets = Tweet.all
    @tweet  = Tweet.new
  end

  #投稿フォーム
  def new
    @tweet = Tweet.new
  end

  #投稿保存
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      redirect_to action: "index"
    else
      redirect_to action: "new"
    end
  end

  #投稿詳細
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
    @comment = @tweet.comments.build
  end

  #投稿削除
  def destroy
    Tweet.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  #セキュリティのため、許可した:bodyというデータだけ取ってくるようにする
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
