class Category < ApplicationRecord
    has_many :categoryings
    has_many :articles, through: :categoryings

    scope :high_priority, ->(limit = nil) { all.order(priority: :desc).limit(limit) }
end
