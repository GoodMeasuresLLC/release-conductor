# Slackistrano

[![Gem Version](https://badge.fury.io/rb/slackistrano.png)](http://badge.fury.io/rb/slackistrano)
[![Code Climate](https://codeclimate.com/github/GoodMeasuresLLC/release-conductor.png)](https://codeclimate.com/github/GoodMeasuresLLC/release-conductor)
[![Build Status](https://travis-ci.org/GoodMeasuresLLC/release-conductor.png?branch=master)](https://travis-ci.org/GoodMeasuresLLC/release-conductor)

Mark the phase of the tickets during releases to staging and production deployments

## Requirements

- Capistrano >= 3.1.0
- Ruby >= 2.0
- A Slack account

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'release-tickets', require: false
```

And then execute:

```bash
$ bundle
```

## Configuration

Require the library in your application's Capfile:

```ruby
require 'slackistrano'
```
Note that in your ENV you must define your unfuddle account and password, like this:

export UNFUDDLE_USER=fred
export UNFUDDLE_PASSWORD=super-duper-secret

This account must have privileges to mark the tickets.


Test your setup by running:

```bash
$ cap production release_conductor:deploy:finished
```

## Usage

Deploy your application like normal and the tickets should be marked.

## TODO

## To publish a new version: (0.0.5 in this example)

1. fix the bug
2. update version.rb
3. git commit -a -m "0.0.5 <my-comment-there>"
4. git tag 0.0.5
5. git push --tags
6. gem build release-conductor.gemspec
7. gem push release-conductor-0.0.5.gem

## To upgrade CODE to use the new version of the gem

1. git checkout code-dev
2. bundle update release-conductor
3. git commit -a -m "@wip upgrading release-conductor gem"
4. git woe minor (OR, merge the new Gemfile.lock into all the branches that need it)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
