module ApplicationHelper
  def extract_title(article)
    if defined? article.title
      article.title
    else
      'No article titles found here'
    end
  end

  def image_render(article)
    if defined? article.pic
      image_tag(cloudinary_url(article.pic.key), class: 'card-img card-img-top w-100 h-100 border-rad-0')
    else
      image_tag('default.jpg', class: 'h-100 w-100 border')
    end
  end

  def extract_body(article)
    if defined? article.body
      article.body
    else
      'No article body found here'
    end
  end

  def edit_article(article)
    return unless !current_user.nil? && article_owner?(article)

    (link_to 'Edit', edit_article_path(article), class: 'btn btn-success w-100 mx-auto')
  end

  def vote_btn(article)
    pre_vote = article.votes.find { |vote| vote.user_id == current_user.id }
    if pre_vote
      (button_to 'Unvote', article_vote_path(article, pre_vote), method: :delete, class: 'btn btn-danger btn-sm')
    else
      (button_to 'vote', article_votes_path(article), method: :post, class: 'btn btn-success btn-sm')
    end
  end

  def nav_item
    links = []
    if user_signed_in?
      links << (active_link_to(current_user.username.upcase, edit_user_registration_path, class: 'nav-link'))
      links << (active_link_to 'Sign out'.upcase, destroy_user_session_path, class: 'nav-link', method: :delete)
      links << (active_link_to 'New article'.upcase, new_article_path, class: 'nav-link')
    else
      links << (active_link_to 'Login'.upcase, new_user_session_path, class: 'nav-link')
      links << (active_link_to 'Sign up'.upcase, new_user_registration_path, class: 'nav-link')
    end
    links
  end
end
