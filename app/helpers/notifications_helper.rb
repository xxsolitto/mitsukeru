module NotificationsHelper

    def notification_form(notification)
        #通知を送ってきたユーザーを取得
        @visitor = notification.visitor
        #コメントの内容を通知に表示する
        @comment = nil
        @visitor_comment = notification.comment_id
        # notification.actionがfollowかlikeかcommentかで処理を変える
        case notification.action
        when 'follow'
          #aタグで通知を作成したユーザーshowのリンクを作成
          tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
        when 'comment' then
          #コメントの内容と投稿のタイトルを取得　      
          @comment = Comment.find_by(id: @visitor_comment)
          @comment_content =@comment.comment
          @tweet_body =@comment.tweet.body
          tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@tweet_body}", href: tweet_path(notification.tweet_id)) + 'にコメントしました'
        end
    end    
    
    def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
    
end
