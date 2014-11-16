# Nifty::Report

Create reports the easy way.

## Installation

Add this line to your application's Gemfile:

    gem 'nifty-report'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nifty-report

## Usage

```
report = Nifty::Report.new('SELECT * FROM users', 'User Report')
report.csv
```

or

```
report = Nifty::Report.new('SELECT * FROM users', 'User Report')
report.email_to('jimtom@example.com')
```

A CSV of all users in the database will be emailed to Jim Tom. You could use
a job queue to delay this as well, which I would recommend.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/nifty-report/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
