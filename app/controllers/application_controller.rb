class ApplicationController < ActionController::Base

  helper_method :github_data

  def welcome
  end

  private

  def github_data
    @github_data = GithubData.repo_hashed_data
  end
end
