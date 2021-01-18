module ArticlesHelper
  def article_owner?(article)
    current_user.id == article.user_id
  end
end
