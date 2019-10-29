class MessagesController < ApplicationController
    # before_action :authenticate_user!

    def index
        if params[:request_id]
            @messages = Message.where(request_id: params[:request_id])
        else
            @messages = Message.all
        end

        render json: @messages.map { |i| {
                :id => i.id, 
                :content => i.content, 
                :request_id => i.request_id, 
                :name => User.find(i.user_id).nickname,
                :created_at => i.created_at,
                :user_id => i.user_id
            }
        }
    end

    def create
        @message = Message.create!(request_params)

        @request = Request.find_by_id(params[:request_id])
        @messages = Message.where(request_id: params[:request_id])
        if @messages.distinct.count(:user_id) == 5
            @request.update_column(:status, 1)
        end
        render json: @message
    end

    private
        def request_params
            params.permit(:id, :content, :user_id, :request_id)
        end
end
