class Api::V1::VotesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @comment = Comment.find(params[:comment_id])
    render json: @comment.vote_tally
  end

  def create
    @voted = JSON.parse(request.body.read)["voted"]
    @comment = Comment.find(params[:comment_id])
    @user = current_user
    votes = Vote.where({user_id: @user, comment_id: @comment.id})

    if votes.exists?
      @comment = vote_exists(votes, @voted, @comment)
    else
      @comment = new_vote(@user, @voted, @comment)
    end

    @comment.save
    render json: @comment.vote_tally
  end

  private

  def vote_exists(votes, voted, comment)
    vote = votes.first
    if vote.voted == voted
      comment = delete_vote(vote, voted, comment)
    else
      comment = change_vote(vote, voted, comment)
    end
    return comment
  end

  def delete_vote(vote, voted, comment)
    vote.destroy
    if voted
      comment.vote_tally -= 1
    else
      comment.vote_tally += 1
    end
    return comment
  end

  def change_vote(vote, voted, comment)
    vote.voted = voted
    vote.save
    if voted
      comment.vote_tally += 2
    else
      comment.vote_tally -= 2
    end
    return comment
  end

  def new_vote(user, voted, comment)
    vote = Vote.new(comment: comment, user: user, voted: voted)
    vote.save
    if voted
      comment.vote_tally += 1
    else
      comment.vote_tally -= 1
    end
    return comment
  end
end
