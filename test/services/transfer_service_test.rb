require "test_helper"
class TransferServiceTest < ActiveSupport::TestCase
    def setup
      # create test data
      @from = User.create(
        name: "John", 
        email: "#{SecureRandom.uuid}@email.com",
        password: "secret"
        )
      @to = User.create(
        name: "Alice", 
        email: "#{SecureRandom.uuid}@email.com",
        password: "secret"
        )
    end
  
    def test_successful_transfer
      # initialize TransferService with test data
      service = TransferService.execute(
        to_id: @to.id,
        transfer_amount: rand(100) * 100,
        transfer_code: "deposit"
      )
  
      # execute the service and check for successful transfer
      assert_equal Money.new(@amount), DoubleEntry.account(:user, scope: User.find(@to.id)).balance
    end
  
    def test_transfer_with_negative_amount
      # initialize TransferService with test data
      service = TransferService.execute(
        from_id: @from.id,
        to_id: @to.id,
        transfer_amount: -10000,
        transfer_code: "transfer",
      )
  
      # execute the service and check for TransferIsNegative error
     assert_equal service.error_messages, "Amount should greather than zero"
    end
  
    def test_transfer_with_blank_to_id
      # initialize TransferService with test data and blank to_id
      service = TransferService.execute(
        to_id: nil,
        transfer_amount: @amount,
        transfer_code: :deposit,
      )
  
      # execute the service and check for MissingAccountError error
      assert_equal service.error_messages, "To id cannot be blank"
    end
  end