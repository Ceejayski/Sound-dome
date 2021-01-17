class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :title, length: { maximum: 30 }
  validates :body, presence: true, length: { minimum: 10 }
  validate :acceptable_image_type?
  belongs_to :user
  has_many :categoryings
  has_many :categories, through: :categoryings
  has_many :votes, dependent: :destroy
  has_one_attached :pic
  after_commit :add_default_pic, on: %i[create]

  scope :most_vote, -> { order(vote_count: :desc).limit(1).first }

  private

  def acceptable_image_type?
    return unless pic.attached?
    return if pic.content_type.in? ['image/png', 'image/jpeg']

    errors.add :pic, 'must be a PNG or JPG'
  end

  def add_default_pic
    unless pic.attached?
      pic.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default.jpg'
          )
        ),
        filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
