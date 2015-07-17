class CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def show
    @messages = Message[@category.id]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Create category successfully"
      redirect_to categories_path
    else
      flash[:danger] = "Create category failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Update category successfully"
      redirect_to category_path @category
    else
      flash[:danger] = "Update category failed"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "Delete category successfully"
    else
      flash[:danger] = "Delete category failed"
    end
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :id
  end

  def set_category
    @category = Category.find_by_id params[:id]
  end
end
