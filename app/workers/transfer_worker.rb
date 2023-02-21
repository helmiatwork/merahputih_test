class TransferWorker
  include Sidekiq::Worker

  def perform(from_id:, to_id:, amount:, transfer_code:)
    TransferService.execute(
      from_id: from_id, 
      to_id: to_id, 
      amount: amount, 
      transfer_code: transfer_code
    )
  end
end
