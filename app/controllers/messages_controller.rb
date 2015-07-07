class MessagesController < ActionController::Base
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find params[:id]
    @category = Category.find_by_id(@message.category_id)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.save
      flash[:success] = "success"
      redirect_to messages_path
    else
      flash[:danger] = "fail"
      render :new
    end
  end

  private
  def message_params
    params.require(:message).permit :content, :category_id, :id
  end
end
