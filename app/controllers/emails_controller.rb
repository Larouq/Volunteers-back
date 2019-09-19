class EmailsController < ApplicationController
    # before_action :authenticate_user!

    require 'mailjet'

    def create
        from_user_email = email_params[:from_user]
        user_id = email_params[:user_id]
        to_user_email = User.find(user_id).email

        Mailjet.configure do |config|
          config.api_key = '181f41f70d1ce77d6b565b9f01da34df'
          config.secret_key = 'ad1b545049d26a289541bbd4b5dbf09d'
          config.api_version = "v3.1"
        end

        variable = Mailjet::Send.create(messages: [{
          'From'=> {
            'Email'=> from_user_email,
          },
          'To'=> [
            {
              'Email'=> to_user_email,
            }
          ],
          'Subject'=> "Volunteers message from #{from_user_email}.",
          'TextPart'=> email_params[:TextPart]
        }]
        )
        p variable.attributes['Messages']

        render json: { :message => "your message was send"}
    end
    private
        def email_params
            params.permit(:from_user, :user_id, :TextPart)
        end
end