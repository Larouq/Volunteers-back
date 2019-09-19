class Request < ApplicationRecord
    validates :title, presence: true
    validates :address, presence: true
    validates :description, presence: true
    belongs_to :user
end