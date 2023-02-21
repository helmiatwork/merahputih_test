class TransferService < ApplicationService
    attr_accessor :from_id, :to_id, :amount, :transfer_code, :note

    TRANSFER_CODES = %i[withdraw deposit transfer].freeze

    def execute
        validate!

        case transfer_code
        when :deposit
            transfer_system_income_to_user
        when :withdraw
            transfer_system_expense_to_user
        when :transfer
            transfer_user_to_user
        end

    rescue => e
        return_errors e
    end

    private

    def transfer_system_income_to_user
        DoubleEntry.transfer(
            transfer_params.merge(
                from: from,
                to: :system_income,
            )
        )
    end

    def transfer_system_expense_to_user
        DoubleEntry.transfer(
            transfer_params.merge(
                from: :system_expense,
                to: to
            )
        )
    end

    def transfer_user_to_user
        DoubleEntry.transfer(
            transfer_params.merge(
                from: from,
                to: to
            )
        )
    end

    def transfer_params
        {
            Money.new(amount),            
            code: transfer_code,
            metadata: {
                note: note,
                uniq: SecureRandom.uuid
            }
        }
    end

    def from
        from ||= User.find(from_id)
    end

    def to
        to ||= User.find(to_id)
    end

    def validate!
        is_from_id_present?
        is_to_id_present?
        is_a_number?
        is_amount_greather_than_zero?
        is_transfer_code_in_scope?
    end

    def is_from_id_present?
        if [:transfer, :deposit].include? transfer_code
            raise "from_id cannot be blank" if from_id.blank?
        end
    end

    def is_to_id_present?
        if [:transfer, :withdraw].include? transfer_code
            raise "to_id cannot be blank" if to_id.blank?
        end
    end

    def is_a_number?
        raise "amount should a numeric" if !amount.is_a? Float || !amount.is_a? Integer
    end

    def is_amount_greather_than_zero?
        raise "amount should greather than zero" if amount <= 0
    end

    def is_transfer_code_in_scope?
        raise "transfer code isn't is scope" if TRANSFER_CODES.include? transfer_code
    end
end