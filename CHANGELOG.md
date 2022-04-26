-- v0.1.0 - First stable version: Typhoeus dependency version updated

-- v0.2.0 - Refactor of cookies format

-- v0.2.1 - Add accessor for base headers and merge method

-- v0.2.2 - delete method added, thanks @pablobfonseca

-- v0.2.3 - adding parameter params in order to handle in_url parameters

-- v0.2.4 - adding parametes to post requests

-- v0.2.5 - adding public method cookie_string

-- v0.3.0 - adding HTTP proxy management and fixing circular reference

-- v0.4.1 - adding random User-Agent generator

-- v0.4.2 - adding ssl verification & deletion of active support methods

-- v0.4.5 - pushing typhoeus version

-- v0.5.0 - Upgrading dependencies and revamping development environment

Bumping required ruby version to >=2.6.0

Upgrading Development dependencies:
- Bundler 2.2
- Rake 13.0
- Rspec 3.10

Swapping CI environment from CircleCI to Github Actions

Upgrading Typhoeus dependency to 1.4.0

-- v0.6.0 - Major refactor of Tweakphoeus::Client API

- New interface for Tweakphoeus::Client
  - Initializer now accepts ssl_verifypeer and redirect parameters instead of having it on all HTTP verb methods (get, delete and post)
  - ssl_verifypeer and redirect parameters removed from HTTP verb methods
  - cookie_jar is not longer an Hash, it has been extracted to Tweakphoeus::CookieJar class
  - refeer_list is not longer an Array, it has been extracted to Tweakphoeus::RefererList class

-- v0.6.1 - Fixing issues with the modification of a frozen string
  - Adds missing requires in the mail `.rb` file
  - Solves an issue with a modification on a frozen string
	> /Users/davidmartingarcia/.rbenv/versions/2.7.4/lib/ruby/gems/2.7.0/gems/tweakphoeus-0.6.0/lib/tweakphoeus/user_agent.rb:17:in `gsub!': can't modify frozen String: "Mozilla/5.0 (X11; gNewSense; Linux x86) Gecko/20100101 Firefox/84.0" (FrozenError)

-- v0.6.2 - Fixing issues with RefererList calls
  - Solves an issue with `RefererList` module calls
    >  /Users/davidmartingarcia/.rbenv/versions/2.7.4/lib/ruby/gems/2.7.0/gems/tweakphoeus-0.6.1/lib/tweakphoeus.rb:36:in `post': undefined method `referer_from_headers' for #<Tweakphoeus::Client:0x00007fec6b13dcd8> (NoMethodError)

-- v0.6.3 - Fixing issues with CookieJar module calls on Tweakphoeus::Client module
  - Solves an issue with a missing CookieJar variable in the  module calls
    > /Users/davidmartingarcia/.rbenv/versions/2.7.4/lib/ruby/gems/2.7.0/gems/tweakphoeus-0.6.2/lib/tweakphoeus.rb:68:in `build_request_headers': undefined local variable or method `url' for #<Tweakphoeus::Client:0x00007ffa882acb48> (NameError)
