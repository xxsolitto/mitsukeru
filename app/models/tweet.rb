class Tweet < ApplicationRecord

    belongs_to :user
    #コメント機能
    has_many :comments, dependent: :destroy

    #通知機能
    has_many :notifications, dependent: :destroy

    def create_notification_comment!(current_user, comment_id)
        #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
        temp_ids = Comment.where(tweet_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
        #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
        temp_ids.each do |temp_id|
          save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end
        #投稿者へ通知を作成
        save_notification_comment!(current_user, comment_id, user_id)
    end
    
    def save_notification_comment!(current_user, comment_id, visited_id)
        notification = current_user.active_notifications.new(
          tweet_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
    end

end
