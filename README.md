# MarcBot

A MARC record generator inspired by [FactoryBot](https://github.com/thoughtbot/factory_bot). 
Use it to create sample MARC records for testing your applications.

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'marc_bot'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install marc_bot

## Usage

Define a factory for a given kind of record you'd like to create and assign its values:

``` ruby
MarcBot.define do
  factory :book do
    f008 { "191003s2020 maua b 001 0 eng d"
    f100 { "Thomas, David" }
    f245 do
      { 
        a: "The pragmatic programmer :",
        b: "your journey to mastery /",
        c: "Dave Thomas, Andy Hunt."
      }
    end
  end
end
```

Then call-up the factory when you need it:

``` ruby
book = MarcBot.build(:book)
```

### Syntax

All tagged fields are prefaced with an "f". If no subfield is specified, `$a` is assumed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/awead/marc_bot.
