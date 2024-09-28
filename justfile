# run it again
try: check
  cargo run --

# unit testing
check:
    cargo clippy
    cargo test --workspace

# add a crate
newdep crate_name: check
    cargo add {{crate_name}}
    cargo doc

# extract version
@version:
  toml get -r Cargo.toml package.version

release_branch := "main"

# error if not on a git branch
on_a_branch:
  #!/bin/bash

  # thanks to https://stackoverflow.com/a/12142066/2002471

  if [[ $(git rev-parse --abbrev-ref HEAD) == "{{release_branch}}" ]]; then
    echo "You are on branch {{release_branch}} (the release branch) so you are not ready to start a PR."
    exit 100
  fi

# thanks to https://stackoverflow.com/a/7293026/2002471 for the perfect git incantation
last_commit_message := `git log -1 --pretty=%B | grep .`

# PR create
pr: on_a_branch
  git stp
  git pushup
  gh pr create --title "{{last_commit_message}}" --body "{{last_commit_message}} (Automated in justfile.)"

# PR merge and return to main branch
merge: on_a_branch
  gh pr merge -s
  git co {{release_branch}}
  git pull

# say hello chicks
hello_chicks:
        #!/usr/bin/env perl
        print "hello chicks\n";

# say howdy internet people
howdy_net:
        #!/usr/bin/env lua
        print("howdy internet people");
