class Request < ApplicationRecord
    validates :title, presence: true
    validates :address, presence: true
    validates :description, presence: true, length: {in: 2..300}
    enum status: [:unfulfilled, :fulfilled]
    belongs_to :user
end