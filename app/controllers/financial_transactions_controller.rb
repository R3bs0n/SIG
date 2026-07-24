class FinancialTransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :load_form_collections, only: %i[new create edit update]

  def index
    scoped = policy_scope(FinancialTransaction)
    @transactions = FinancialTransactionsQuery.new(scoped, filter_params).call
    @categories = policy_scope(Category).order(:name)
  end

  def show
    authorize @transaction
  end

  def new
    @transaction = current_user.company.financial_transactions.new(due_date: Date.current, status: "pending")
    authorize @transaction
  end

  def create
    @transaction = TransactionCreateService.new(
      company: current_user.company,
      user: current_user,
      attributes: transaction_params
    ).call
    authorize @transaction

    if @transaction.persisted?
      redirect_to financial_transactions_path, notice: "Lancamento criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @transaction
  end

  def update
    authorize @transaction

    if @transaction.update(transaction_params)
      redirect_to financial_transactions_path, notice: "Lancamento atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @transaction
    @transaction.destroy
    redirect_to financial_transactions_path, notice: "Lancamento removido com sucesso."
  end

  private

  def set_transaction
    @transaction = policy_scope(FinancialTransaction).find(params[:id])
  end

  def load_form_collections
    @accounts = policy_scope(FinancialAccount).active.order(:name)
    @categories = policy_scope(Category).order(:kind, :name)
  end

  def transaction_params
    params.require(:financial_transaction).permit(
      :financial_account_id, :category_id, :description, :kind, :amount,
      :due_date, :paid_at, :status, :notes
    )
  end

  def filter_params
    params.permit(:kind, :status, :category_id, :from, :to)
  end
end
