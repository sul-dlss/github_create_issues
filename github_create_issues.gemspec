Gem::Specification.new do |s|
  s.add_development_dependency 'octokit', '>= 4.6'

  s.name        = 'github_create_issues'
  s.version     = '0.0.4'
  s.date        = '2017-02-18'
  s.summary     = 'Create and maintain github issues'
  s.description = 'This takes lists of issues to create in a github repository, each marked with a specific label, and creates them.  If any issues already exist, a new comment will be created instead.  It is meant to offer a way for scripts to notify a repo of normal actionable items when using a repo as work tracking.'
  s.authors     = [ 'Jon Robertson' ]
  s.email       = 'jonrober@stanford.edu'
  s.files       = [ 'CHANGELOG.md', 'README.md', 'lib/github_create_issues.rb' ]
  s.homepage    = 'http://github.com/sul-dlss/github-create-issues'
  s.license     = 'MIT'
end
