# README

## Setup

* Ruby v2.6.3 (rbenv recommended to install ruby versions)
* Install bundler `gem install bundler`
* cd to project root and run `bin/bundle install`
* Setup database `bin/rails db:setup`
* Start the web server `bin/rails s`

## Tests

Followed TDD for this assignment, to run the RSpec test for the request:

`bin/bundle exec rspec spec/requests/transfer_send_money_spec.rb`

## Application

### View Users and Accounts in database

In a web browser

Users: `http://localhost:3000/users`

Accounts: `http://localhost:3000/accounts`

### Execute transfer between two accounts

#### POST /transfer

URI `http://localhost:3000/transfer`

JSON input parameters:

```
{
	"fromAccountId": 2,
	"toAccountId": 18,
	"amount": 50.00
}
```

Sample JSON response:

```
{
  "newSrcBalance": 34.06,
  "totalDestBalance": 94.03,
  "transferedAt": "2020-08-11T18:26:16.068+05:30"
}
```

#### Error Codes
* `-1` for insufficient balance
* `-2` for BasicSaving Account exceeding balance limit of Rs. 50,000
* `-3` for transfers between the same user

## Author
Vishal Ravi Shankar

## Links
1. rbenv https://github.com/rbenv/rbenv
2. Bundler https://bundler.io/

