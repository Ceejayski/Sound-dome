module ArticlesHelper
  def article_owner?
    current_user.id == @article.user_id
  end
end
