class Yugioh < ApplicationRecord
    validates :user_id, presence: true
    validates :description, presence: true
    validates :time, presence: true
    validates :schedule, presence: true
    belongs_to :user, optional: true
    
    has_many :yugiohs
end
