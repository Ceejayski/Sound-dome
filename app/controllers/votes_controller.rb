class VotesController < ApplicationController
  before_action :find_article
  before_action :find_vote, only: [:destroy]
  def create
    if already_voted?
      flash[:notice] = "You can't vote more than once"
    else
      @article.votes.create(user_id: current_user.id)
      @article.increment!(:vote_count)
    end
    redirect_to article_path(@article)
  end

  def destroy
    if !already_voted?
      flash[:notice] = 'Cannot unvote'
    else
      @vote.destroy
    end
    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def find_vote
    @vote = @article.votes.find(params[:id])
  end
end
