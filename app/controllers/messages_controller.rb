class MessagesController < ApplicationController
    # before_action :authenticate_user!

    def index
        if  params[:user_id]
            userid = params[:user_id]
            @messages = Message.where(user_id: userid)
        else
            @messages = Message.all
        end
        render json: @messages
    end

    def create
        @message = Message.create!(request_params)
        render json: @message
    end

    private
        def request_params
            params.permit(:id, :content, :user_id)
        end
end
