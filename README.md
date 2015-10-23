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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
