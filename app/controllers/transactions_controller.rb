class TransactionsController < ApplicationController
  def validate
    transaction = Customer::Transaction.find_by(id: params[:id])
    Admin::TransactionValidator.new(transaction).call
  end
end
