class MessagesController < ApplicationController
    def create
        if Entry.where(user_id: current_user.id, chat_id: params[:message][:chat_id]).present?
          @message = Message.new(message_params)
          # ここから
          @chat=@message.chat
          # ここまでを追加
          if @message.save

            # ここから
            @chatmembernotme=Entry.where(chat_id: @chat.id).where.not(user_id: current_user.id)
            @theid=@chatmembernotme.find_by(chat_id: @chat.id)
            notification = current_user.active_notifications.new(
                chat_id: @chat.id,
                message_id: @message.id,
                visited_id: @theid.user_id,
                visitor_id: current_user.id,
                action: 'dm'
            )
            # 自分の投稿に対するコメントの場合は、通知済みとする
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
            # ここまでを追加

            redirect_to "/chats/#{@message.chat_id}"
          end
        else
          redirect_back(fallback_location: root_path)
        end
    end

    private 
      def message_params
          params.require(:message).permit(:user_id, :content, :chat_id).merge(user_id: current_user.id)
      end
end

