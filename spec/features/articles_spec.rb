require 'rails_helper'
# spec/features/articles_spec.rb
RSpec.describe 'Articles', type: :feature do
  let(:test_user) { User.create(username: 'User_Test', email: 'user@example.com', password: 'password') }

  describe 'create post' do
    it 'path is correct' do
      test_user
      visit new_user_session_path
      fill_in('user[email]', with: 'user@example.com')
      fill_in('user[password]', with: 'password')
      click_button('Log in')
      visit new_article_path
      fill_in('article[title]', with: 'title')
      fill_in('article[body]', with: 'this is an example post')
      click_button('Create Article')
      visit articles_path
      expect(page).to have_content('this is an example post')
      article = Article.find_by(body: 'this is an example post')
      visit article_path(article)
      click_button('vote', match: :first)
    end
  end
end
