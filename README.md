# LogExtractor

Simple tool to extract and parse logs easily from ELK.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "log_extractor"
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install log_extractor
```

## Usage

Setup an environment variable with the url from your ELK server to extract the logs:

```bash
export ELASTICSEARCH_URL=http://localhost:9200/
```

Pick a query (Lucene) and a period (in minutes, 15 minutes by default), and you'll have every matching log in a block ready to extract whatever you need:

```ruby
LogExtractor::Extract.(query: "[your query]", period: 15) do |log|
  puts log.timestamp
  puts log.inspect
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sergiogomez/log_extractor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sergiogomez/log_extractor/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LogExtractor project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sergiogomez/log_extractor/blob/main/CODE_OF_CONDUCT.md).
