# Apps

This is a toolkit to easily integrate into platform marketplaces and extension points. These tools help with various integration points and common boilerplate needed to get going.

The Apps gem is currently under development, with the goal of facilitating the following:

* Google
  * [Gmail Add-ons](https://developers.google.com/gmail/add-ons/)
  * [Gmail Email Markup](https://developers.google.com/gmail/markup/)
  * AMP Pages
* Microsoft Office 365
  * [Outlook Add-ins](https://docs.microsoft.com/en-us/outlook/add-ins/)
  * [Outlook Actionable Messages](https://docs.microsoft.com/en-us/outlook/actionable-messages/)
* Slack
  * Bots
  * Commands
* Heroku
  * Addons Marketplace (SSO)
* Facebook
  * Instant Articles

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apps

## Usage

### Gmail Email Markup

You can generate [schema.org](http://schema.org) markup for email in Gmail utilizing simple helper classes.

* Use the helper methods in `Apps::Adapters::Gmail::Markup` to easily define your markup
* Helper methods to generate an object model for you to "fill in":
  * Confirm Action - `Apps::Adapters::Gmail::Markup#build_confirm_action`
  * Save Action - `Apps::Adapters::Gmail::Markup#build_save_action`
  * RSVP Action - `Apps::Adapters::Gmail::Markup#build_rsvp_action`
  * View Action - `Apps::Adapters::Gmail::Markup#build_view_action`
  * Track Action - `Apps::Adapters::Gmail::Markup#build_track_action`
* Helper methods to serialize your object model:
  * `as_json` generates a `Hash` represenation of metadata
  * `to_json` generates a JSON string representation of metadata
  * `to_script` generates a "pretty" JSON enclosed by `script` tags specifying `JSON-LD` type
    * NOTE: `to_script` is only available on "context" objects that represent the root of the markup needed for embedding in emails. This is the object returned by each of the helper methods above for each "Action"

#### TODO

* Basic handler endpoints for "Actions" to interact with need to be facilitated (e.g. for RSVP Action)
* Email Markup helpers for other Gmail-supported metadata need to be implemented
* Additional Gmail integrations need to be developed

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joelvh/apps. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
