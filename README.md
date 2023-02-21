# README

## Ruby version
- 3.2.1

## Rails Version
- 7.0.4

## Database
- Sqlite3

## Cache management
- Redis

## How to run the app locally
- `cd` into the project directory
- `bundle install`
- `rails db:setup`
- `rails db:seed`
- `rails server`
-  Open new terminal tab and run `sidekiq` to process background job
- or you can run `bin/server` once you execute `db:setup` at first already

## Additional gems
- `gem "administrate", "~> 0.18.0"`
- `gem "devise", "~> 4.9"`
- `gem "double_entry", github: "envato/double_entry"`
- `gem "sidekiq", "~> 7.0"`
- `gem "redis-rails", "~> 5.0"`
- `gem "standardrb", "~> 1.0"`
- `gem "breadcrumbs_on_rails", "~> 4.1"`

## Administrate gem
Administrate is a library for Rails apps that automatically generates admin dashboards. Administrate's admin dashboards give non-technical users clean interfaces that allow them to create, edit, search, and delete records for any model in the application.


## Devise gem
Devise is a flexible authentication solution for Rails based on Warden. It:

- Is Rack based;
- Is a complete MVC solution based on Rails engines;
- Allows you to have multiple models signed in at the same time;
- Is based on a modularity concept: use only what you really need.

## Double entry gem
DoubleEntry is an accounting system based on the principles of a Double-entry Bookkeeping system. While this gem acts like a double-entry bookkeeping system, as it creates two entries in the database for each transfer, it does not enforce accounting rules, other than optionally ensuring a balance is positive, and through an allowlist of approved transfers.

## Sidekiq
Simple, efficient background processing for Ruby.

Sidekiq uses threads to handle many jobs at the same time in the same process. It does not require Rails but will integrate tightly with Rails to make background processing dead simple.
