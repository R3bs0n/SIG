# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.present?
  end

  def show?
    same_company?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    same_company?
  end

  def edit?
    update?
  end

  def destroy?
    user&.admin? && same_company?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.none unless user
      return scope.where(company_id: user.company_id) if scope.column_names.include?("company_id")

      scope.all
    end

    private

    attr_reader :user, :scope
  end

  private

  def same_company?
    return false unless user && record
    return true unless record.respond_to?(:company_id)

    record.company_id == user.company_id
  end
end
