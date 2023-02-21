# app/dashboards/stat_dashboard.rb
require "administrate/custom_dashboard"

module Admin
  class TransactionsController < Admin::ApplicationController
    before_action :set_selected_users
    before_action :set_transfer_codes

    add_breadcrumb :transactions

    def index
      
    end

    def permitted_params
      params.permit(:from_id, :to_id, :amount, :transfer_code)
    end

    def set_selected_counter
      @users ||= User.all
    end

    def transfer_codes
    end
  end
end
