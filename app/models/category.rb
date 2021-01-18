class Category < ApplicationRecord
  has_many :categoryings
  has_many :articles, through: :categoryings

  scope :most_recent, ->(category) { find(category.id).articles.order(created_at: :desc).limit(1).first }
  scope :high_priority, ->(limit = nil) { all.order(priority: :desc).limit(limit) }
end
