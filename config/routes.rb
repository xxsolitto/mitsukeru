Rails.application.routes.draw do

  #ログイン機能
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #sign_out
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  #投稿一覧(TL)
  #get 'tweets' => 'tweets#index'
  #新規投稿作成ページ表示
  #get 'tweets/new' => 'tweets#new'
  #投稿し、ホームにリダイレクト
  #post 'tweets' => 'tweets#create'
  #投稿詳細を表示する
  post 'tweets/:id' => 'tweets#show'
  #投稿を削除する
  #delete 'tweets/:id'      => 'tweets#destroy'
  resources :tweets do
    resources :comments, only: [:create, :destroy]
  end

  #ユーザーページを表示
  resources :users, :only=>[:index, :show]
  get 'users' => 'users#index'
  
  get 'users/edit'

  #DM機能
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]

  #TOPページ
  root 'root#index'
  get 'root/index' => 'root#index'

  #フォロー機能
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  #通知機能
  resources :notifications, only: [:index, :destroy]

end
