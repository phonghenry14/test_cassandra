class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find params[:id]
    @messages = Message.where(:category_id, @category.id)
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

  private
  def category_params
    params.require(:category).permit :name, :description, :id
  end
end
