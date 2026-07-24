class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = policy_scope(Category).order(:kind, :name)
  end

  def new
    @category = current_user.company.categories.new
    authorize @category
  end

  def create
    @category = current_user.company.categories.new(category_params)
    authorize @category

    if @category.save
      redirect_to categories_path, notice: "Categoria criada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @category
  end

  def update
    authorize @category

    if @category.update(category_params)
      redirect_to categories_path, notice: "Categoria atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category
    @category.destroy
    redirect_to categories_path, notice: "Categoria removida com sucesso."
  end

  private

  def set_category
    @category = policy_scope(Category).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :kind, :color)
  end
end
