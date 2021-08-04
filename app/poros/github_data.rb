class GithubData 

  def self.repo_name
    repo = GithubServices.get_repo_name
    JSON.parse(repo)['name']
  end

  def self.repo_contributors
      contributors = GithubServices.get_contributors.map do |contributor|
      user_ids = [80797707, 81220681, 79381792, 60951642]
      if user_ids.include?(contributor['id'])
        contributor['login']
      end
    end
    contributors.compact()
  end

  def self.repo_commits
    commits = GithubServices.get_commits
    contributors = repo_contributors
    hash = {}
    user_ids = [80797707, 81220681, 79381792, 60951642]
    user_ids.each_with_index do |user_id, i|
      count = JSON.parse(commits).count do |commit|
        commit['author']['id'] == user_id
      end
      hash[contributors[i]] = count
    end
    hash
  end

  def self.repo_pr_count
    pulls = GithubServices.get_pulls
    JSON.parse(pulls).count
  end

  def self.repo_hashed_data
    hash = {}
    hash[:repo_name] = repo_name
    hash[:contributors_commits] = repo_commits
    hash[:repo_pr_count] = repo_pr_count
    hash
  end
end