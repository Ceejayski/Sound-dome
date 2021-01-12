class Category < ApplicationRecord
    has_many :categoryings
    has_many :articles, through: :categoryings
end
