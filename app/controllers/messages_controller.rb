class MessagesController < ApplicationController
  def index
    if params[:query].present?
      @messages = Message.search_with_elastic params[:query]
    else
      @messages = Message.all
    end
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

  private
  def message_params
    params.require(:message).permit :content, :category_id, :id
  end
end
