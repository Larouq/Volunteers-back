class RequestsController < ApplicationController
    # before_action :authenticate_user!

    def index
        if  params[:user_id]
            userid = params[:user_id]
            @requests = Request.where(user_id: userid)
        else
            @requests = Request.all
        end
        render json: @requests.map { |i| {
            :id => i.id,
            :title => i.title,
            :description => i.description,
            :lat => i.lat,
            :lng => i.lng,
            :address => i.address,
            :user_id => i.user_id,
            :created_at => i.created_at,
            :updated_at => i.updated_at,
            :category => i.category,
            :user_name => i.user_name,
            :status => i.status,
            :statement => i.statement,
            :count_helper => Request.find(i.id).response.count
        }}
    end

    def create
        @request = Request.create!(request_params)
        render json: @request
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