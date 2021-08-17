[![Gem Version](https://badge.fury.io/rb/tweakphoeus.svg)](https://badge.fury.io/rb/tweakphoeus)
[![Code Climate](https://codeclimate.com/github/basestylo/Tweakphoeus/badges/gpa.svg)](https://codeclimate.com/github/basestylo/Tweakphoeus)
[![Issue Count](https://codeclimate.com/github/basestylo/Tweakphoeus/badges/issue_count.svg)](https://codeclimate.com/github/basestylo/Tweakphoeus)
# Tweakphoeus

We usually describe this gem as 'typhoeus on steroids'. We add some browser features, for example cookies management and automation in tipical headers that browsers define in his HTTP stack.

We love scrapping and this gem was created for this.

From crazy developers to another crazy developers, Created in Bizneo.com and maintained in this small group of developers.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tweakphoeus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tweakphoeus

## Usage
Like Typhoeus

Tweakphoeus.get(url)
Tweakphoeus.get(url, headers: hash, body: hash)

TODO: Write usage instructions here

### Using proxies
To use HTTP proxies with optional basic authorization, use `set_proxy(url[, user: <user>, password: <pass>])`. Proxy can be disabled with `unset_proxy`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tweakphoeus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
