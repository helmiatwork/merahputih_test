# app/dashboards/stat_dashboard.rb
require "administrate/custom_dashboard"

module Admin
  class TransactionsController < Admin::ApplicationController
    before_action :set_selected_users
    before_action :set_transfer_codes

    add_breadcrumb "transactions"

    def index
      @transactions = DoubleEntryLine.order(created_at: :desc)
    end

    def create
      response = TransferService.execute(permitted_params.as_json)
      if response.success?
        flash[:success] = "Successfully #{permitted_params[:transfer_code]} $ #{permitted_params[:transfer_amount]}"
      else
        flash[:error] = "Failed #{permitted_params[:transfer_code]}"
      end

      redirect_to admin_transactions_path
    end

    def permitted_params
      params.permit(:from_id, :to_id, :transfer_amount, :transfer_code)
    end

    def set_selected_users
      @users ||= User.all
    end

    def set_transfer_codes
      @transfer_codes ||= TransferService::TRANSFER_CODES
    end
  end
end
