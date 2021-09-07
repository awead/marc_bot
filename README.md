# MarcBot

A MARC record generator inspired by [FactoryBot](https://github.com/thoughtbot/factory_bot). 
Use it to create sample MARC records for testing your applications.

Note: This is in a very alpha state. Comments, architecture suggestions, and feature requests are all welcome

## Setup

Add the gem to you Gemfile. You'll probably only want this in your dev and test environments. And, while you're at
it, why don't you add Faker too?

Add this line to your application's Gemfile

``` ruby
group :development, :test do 
  gem 'faker'
  gem 'marc_bot'
end
```

And then execute:

    bundle install

Or install the gem directly:

    gem install marc_bot

### Usage with RSpec

If you're running this in a test suite, such as RSpec, you'll need to initialize your factory definitions:

``` ruby
require 'faker'
require 'marc_bot'

RSpec.configure do |config|
  config.before(:suite) do
    MarcBot.reload
  end
end
```

## Usage

Create a directory to store all of you different factory definitions. Borrowing from FactoryBot, these directories
are:

* records
* test/records
* spec/records

Create a file in one of those directories--it can have any name, so long as it ends in `.rb`--and 
define a factory for a given kind of record you'd like to create and assign its values:

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
    f650 do
      {
        z: ["Books", "Programming"]
      }
    end
  end
end
```

Then call-up the factory when you need it:

``` ruby
book = MarcBot.build(:book)
```

You can also pass in additional fields at build time:

``` ruby
book = MarcBot.build(:book, f949: { a: "QA76.6.T4494 2020", w: "LC" })
```

### Syntax

All tagged fields should be prefaced with an "f", although technically, any non-numeric set of letters is fine. We're
just looking for three numbers. If no subfield is specified, `$a` is assumed.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/awead/marc_bot.
