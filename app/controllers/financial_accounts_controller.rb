class FinancialAccountsController < ApplicationController
  before_action :set_financial_account, only: %i[show edit update destroy]

  def index
    @financial_accounts = policy_scope(FinancialAccount).order(:name)
  end

  def show
    authorize @financial_account
  end

  def new
    @financial_account = current_user.company.financial_accounts.new
    authorize @financial_account
  end

  def create
    @financial_account = current_user.company.financial_accounts.new(financial_account_params)
    authorize @financial_account

    if @financial_account.save
      redirect_to financial_accounts_path, notice: "Conta criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @financial_account
  end

  def update
    authorize @financial_account

    if @financial_account.update(financial_account_params)
      redirect_to financial_accounts_path, notice: "Conta atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @financial_account
    @financial_account.destroy
    redirect_to financial_accounts_path, notice: "Conta removida com sucesso."
  end

  private

  def set_financial_account
    @financial_account = policy_scope(FinancialAccount).find(params[:id])
  end

  def financial_account_params
    params.require(:financial_account).permit(:name, :account_type, :opening_balance, :active)
  end
end
