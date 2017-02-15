# Overview

This is a ruby module to create and maintain a list of issues for a git repo.
It's meant for a use case where we are using issues for general internal
ticketing, and it would be useful to let some of our automated processes be
able to create tickets from actionable data.

It's a fairly simple wrapper around the Octokit gem.  Given an OAuth token,
a repository, a label, a list of issue titles, and the text for those issues,
it seeks to create the given issues.  If issues with those titles already
exist and are open, then we add a comment that the given issue is ongoing.

An example of how we use it is that we have a script that each week sends a
list of servers that haven't checked in to puppet lately.  We can use this to
instead create an issue for each server for someone to handle, and keep noting
in the comments if it's not been dealt with on future runs.

The label will be created if it does not exist, and is used to limit the scope
of the library to only things with that label.  If you have multiple programs
using this library to handle issues, then it's probably best to give each a
unique label.
