class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :title, length: { maximum: 30 }
  validates :text, presence: true, length: { minimum: 10 }
  belongs_to :user
  has_many :categoryings
  has_many :categories, through: :categoryings
  has_many :votes, dependent: :destroy

  scope :most_vote, -> { order(vote_count: :desc).limit(1).first }
end
