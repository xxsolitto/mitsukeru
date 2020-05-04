class Comment < ApplicationRecord

  belongs_to :tweet
  belongs_to :user

  #通知機能
  has_many :notifications, dependent: :destroy

end
