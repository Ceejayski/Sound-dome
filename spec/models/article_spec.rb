require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:test_user) { User.create(username: 'Example User', password: 'password') }
  let(:subject) do
    described_class.new(
      title: 'Example title',
      body: 'example body',
      user_id: test_user.id
    )
  end

  describe 'Associations', type: :model do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:votes) }
    it { is_expected.to have_many(:categoryings) }
    it { is_expected.to have_many(:categories) }
  end
  describe 'Validations', type: :model do
    it 'Title cannot be longer than 30' do
      subject.title = '0' * 1001
      expect(subject).not_to be_valid
    end
    it { is_expected.to validate_presence_of(:title) }
    it 'is not valid without a title' do
      article = Article.new(title: nil)
      expect(article).to_not be_valid
    end
    it { is_expected.to validate_presence_of(:body) }
    it 'is not valid without a body' do
      article = Article.new(body: nil)
      expect(article).to_not be_valid
    end
  end

  describe 'Attachment' do
    it 'is valid  ' do
      subject.pic.attach(io: File.open(fixture_path + '/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
      expect(subject.pic).to be_attached
    end
    it 'is not att ' do
      article = Article.new(pic: nil)
      expect(article.pic).to_not be_attached
    end
  end
end
