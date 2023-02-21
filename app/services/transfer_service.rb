class TransferService < ApplicationService
    attr_accessor :from_id, :to_id, :transfer_amount, :transfer_code, :note

    TRANSFER_CODES = %i[withdraw deposit transfer].freeze

    def execute
        validate!
        self.send(transfer_code)
        
    rescue DoubleEntry::AccountWouldBeSentNegative => e
        return_errors "AccountWouldBeSentNegative"
    rescue DoubleEntry::DoubleEntryError => e
        return_errors "DoubleEntryError"
    rescue DoubleEntry::UnknownAccount => e
        return_errors "UnknownAccount"
    rescue DoubleEntry::AccountIdentifierTooLongError => e
        return_errors "AccountIdentifierTooLongError"
    rescue DoubleEntry::ScopeIdentifierTooLongError => e
        return_errors "ScopeIdentifierTooLongError"
    rescue DoubleEntry::TransferNotAllowed => e
        return_errors "TransferNotAllowed"
    rescue DoubleEntry::TransferIsNegative => e
        return_errors "TransferIsNegative"
    rescue DoubleEntry::TransferCodeTooLongError => e
        return_errors "TransferCodeTooLongError"
    rescue DoubleEntry::DuplicateAccount => e
        return_errors "DuplicateAccount"
    rescue DoubleEntry::DuplicateTransfer => e
        return_errors "DuplicateTransfer"
    rescue DoubleEntry::AccountWouldBeSentNegative => e
        return_errors "AccountWouldBeSentNegative"
    rescue DoubleEntry::AccountWouldBeSentPositiveError => e
        return_errors "AccountWouldBeSentPositiveError"
    rescue DoubleEntry::MismatchedCurrencies => e
        return_errors "MismatchedCurrencies"
    rescue DoubleEntry::MissingAccountError => e
        return_errors "MissingAccountError"
    rescue => e
        return_errors e
    end

    private

    def amount
        transfer_amount.to_i * 100
    end

    def deposit
        DoubleEntry.transfer(
            Money.new(amount), 
            from: system_expense, 
            to: to,
            code: transfer_code.to_sym
        )
    end

    def withdraw
        DoubleEntry.transfer(
            Money.new(amount), 
            from: from, 
            to: system_income,
            code: transfer_code.to_sym
        )
    end

    def transfer
        DoubleEntry.transfer(
            Money.new(amount), 
            from: from, 
            to: to,
            code: transfer_code.to_sym
        )
    end

    def system_income
        DoubleEntry.account(:system_income)
    end

    def system_expense
        DoubleEntry.account(:system_expense)
    end

    def from
        @from ||= DoubleEntry.account(:user, scope: User.find(from_id))
    end

    def to
        @to ||= DoubleEntry.account(:user, scope: User.find(to_id))
    end

    def validate!
        is_from_id_present?
        is_to_id_present?
        is_a_number?
        is_amount_greather_than_zero?
        is_transfer_code_in_scope?
    end

    def is_from_id_present?
        if [:transfer, :withdraw].include? transfer_code
            raise "from_id cannot be blank" if from_id.blank?
        end
    end

    def is_to_id_present?
        if [:transfer, :deposit].include? transfer_code
            raise "to_id cannot be blank" if to_id.blank?
        end
    end

    def is_a_number?
        raise "amount should a Integer e.g $100.10 please write 10010" if !amount.is_a?(Integer)
    end

    def is_amount_greather_than_zero?
        raise "amount should greather than zero" if amount <= 0
    end

    def is_transfer_code_in_scope?
        raise "transfer code isn't is scope" if TRANSFER_CODES.include? transfer_code
    end
end