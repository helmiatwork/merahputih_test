# app/dashboards/transaction_dashboard.rb
require "administrate/custom_dashboard"

class TransactionDashboard < Administrate::CustomDashboard
  resource "Transaction" # used by administrate in the views
end
