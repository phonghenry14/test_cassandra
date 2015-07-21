class MessagesController < ApplicationController
  before_action :set_message, except: [:index, :new, :create]

  def index
    messages = params[:query].present? ? Message.search_with_elastic(params[:query]) : Message.all.to_a
    @messages = Kaminari.paginate_array(messages).
      page(params[:page]).per Settings.limits.message_lists
  end

  def show
    @category = Category.find_by_id @message.category_id
    @message.increase_pageview!
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.save
      flash[:success] = "Create message successfully"
      redirect_to messages_path
    else
      flash[:danger] = "Create message failed"
      render :new
    end
  end

  def update
    if @message.update_attributes message_params
      flash[:success] = "Update message successfully"
      redirect_to message_path @message
    else
      flash[:danger] = "Update message failed"
      render :edit
    end
  end

  def destroy
    if @message.destroy
      flash[:success] = "Delete message successfully"
    else
      flash[:danger] = "Delete message failed"
    end
    redirect_to messages_path
  end

  private
  def message_params
    params.require(:message).permit :content, :category_id
  end

  def set_message
    @message = Message[params[:category_id]][params[:id]]
  end
end
