class GithubServices
  def self.get_repo_name
    response = Faraday.get 'https://api.github.com/repos/scott-borecki/little-esty-shop'
    repo = response.body
  end

  def self.get_contributors
    response = Faraday.get 'https://api.github.com/repos/scott-borecki/little-esty-shop/contributors'
    response = response.body
    JSON.parse(response)
  end

  def self.get_commits
    response = Faraday.get 'https://api.github.com/repos/scott-borecki/little-esty-shop/commits'
    commits = response.body
  end

  def self.get_pulls
    response = Faraday.get 'https://api.github.com/repos/scott-borecki/little-esty-shop/pulls?state=all'
    response.body
  end
end