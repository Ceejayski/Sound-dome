require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Associations', type: :model do
    it { is_expected.to have_many(:categoryings) }
    it { is_expected.to have_many(:articles) }
  end
end
