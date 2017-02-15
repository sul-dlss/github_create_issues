# Create and maintain Github issues for a repository via the API.  This adds
# issues with a given label, and adds a time ping comment if the issue already
# exists and is open.  It's meant to be used by scripts that want to push
# actionable items into github issues on a regular basis.
class GithubCreateIssues
  require 'octokit'

  # Add a label to a repository if it does not yet exist.
  #
  # [token] String.  OAuth token.
  # [repo] String.  Name of the resposity that the label should exist in.
  # [name] String.  Name of the label we want to exist.
  def self.add_label(token, repo, name)
    exists = true

    client = Octokit::Client.new(:access_token => token)
    begin
      client.label(repo, name)
    rescue Octokit::NotFound
      exists = false
    end
    return unless exists == false

    client.add_label(repo, name)
  end

  # Add issues to a github repo.  We take a label that is set for any issues
  # we create, a list of servers, and an error message to add to the issue.  If
  # there is already an open issue for any server, just add a comment to ping.
  #
  # [token] String.  OAuth token.
  # [repo] String.  Name of the resposity that the label should exist in.
  # [label] String.  Name of the label connected to these issues.
  # [titles] Array of strings.  The titles of each issue we want to exist.
  # [desc] String.  Description to enter in the issue text.
  def self.add_github_issues(token, repo, label, titles, desc)
    add_label(token, repo, label)

    client = Octokit::Client.new(:access_token => token)
    client.auto_paginate = true
    issues = client.issues repo, state: 'open', labels: label

    # For each open issue, see if there is already an issue by that title.  If
    # so, set a comment to ping that it's still ongoing and remove the title
    # from the list.
    issues.each do |i|
      next unless titles.include?(i.title)

      current = Time.new.getlocal
      comment = "Issue recurred at #{current}"
      client.add_comment repo, i.number, comment
      titles.delete(i.title)
    end

    # For those servers without issues already open, create an issue for each.
    titles.each do |t|
      client.create_issue repo, t, desc, labels: label
    end
  end
end
