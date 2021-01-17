require 'rails_helper'

RSpec.describe Categorying, type: :model do
  describe 'Associations', type: :model do
    it { is_expected.to belong_to(:article) }
    it { is_expected.to belong_to(:category) }
  end
end
