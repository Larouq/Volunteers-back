class Response < ApplicationRecord
    belongs_to :user
    belongs_to :request
    has_many :message
end