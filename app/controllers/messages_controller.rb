class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
        if params[:response_id]
            @messages = Message.where(response_id: params[:response_id])
        else
            @messages = Message.all
        end

        render json: @messages.map { |i| {
                :id => i.id, 
                :content => i.content, 
                :response_id => i.response_id, 
                :name => User.find(i.user_id).nickname,
                :created_at => i.created_at,
                :user_id => i.user_id
            }
        }
    end

    def create
        @message = Message.create!(request_params)
        
        render json: @message
    end

    private
        def request_params
            params.permit(:id, :content, :user_id, :response_id)
        end
end
