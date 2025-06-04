class TransactionsController < ApplicationController
  def validate
    transaction = Transaction.find_by(id: params[:id])
    Admin::TransactionValidator.new(transaction).call
  end
end
