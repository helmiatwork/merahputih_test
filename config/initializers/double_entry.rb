

require_relative "money"
require "double_entry"

DoubleEntry.configure do |config|
  # Use json(b) column in double_entry_lines table to store metadata instead of separate metadata table
  # config.json_metadata = true

  config.define_accounts do |accounts|
    scope = ->(user) do
      if user.is_a?(User)
        user.id
      else
        raise "The scope is only accepted for User"
      end
    end
    
    accounts.define(identifier: :system_expense, currency: :USD)
    accounts.define(identifier: :system_income, currency: :USD, positive_only: true)
    accounts.define(identifier: :user, scope_identifier: scope, currency: :USD, positive_only: true)
  end

  config.define_transfers do |transfers|
    transfers.define(from: :system_expense, to: :user, code: :withdraw)
    transfers.define(from: :user, to: :system_income, code: :deposit)
  end
end