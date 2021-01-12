class Article < ApplicationRecord
  belongs_to :user
  has_many :categoryings
  has_many :categories, through: :categoryings
end
