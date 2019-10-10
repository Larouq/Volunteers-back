class RequestsController < ApplicationController
    # before_action :authenticate_user!

    def index
        if  params[:user_id]
            userid = params[:user_id]
            @requests = Request.where(user_id: userid)
        else
            @requests = Request.all
        end
        render json: @requests
    end

    def create
        @request = Request.create!(request_params)
        render json: @request
    end

    def destroy
        @requests = Request.find(params[:id])
        @requests.destroy
        render json: @requests
    end

    def update
        @request = Request.find(params[:id])
        @request.update_attributes(request_params)

        render json: @request
    end
    
    private
        def request_params
            params.permit(:id, :title, :description, :address, :lat, :lng, :user_id, :category, :user_name, :statement, :status)
        end
end