class ResponsesController < ApplicationController
    # before_action :authenticate_user!

    def index
        if params[:request_id]
            @responses = Response.where(request_id: params[:request_id])
        else
            @responses = Response.all
        end

        render json: @responses.map { |i| {
                :id => i.id,
                :user_id => i.user_id,
                :request_id => i.request_id,
                :name => User.find(i.user_id).nickname,
                :messages => Message.where(:response_id => i.id).map { |i| {
                        :id => i.id, 
                        :content => i.content, 
                        :response_id => i.response_id, 
                        :name => User.find(i.user_id).nickname,
                        :created_at => i.created_at,
                        :user_id => i.user_id
                    }
                }

            }

        }
    end

    def create
        @response = Response.create!(
            id: params[:id], 
            user_id: params[:user_id], 
            request_id: params[:request_id]
        )

        Message.create(
            user_id: @response.user_id, 
            response_id: @response.id,
            content: params[:content]
        )

        @request = Request.find_by_id(params[:request_id])
        @responses = Response.where(request_id: params[:request_id])
        if @responses.distinct.count(:user_id) == 5
            @request.update_column(:status, 1)
        end

        render json: @response
        
    end

    private
        def response_params
            params.permit(:id, :user_id, :request_id, :content)
        end
end