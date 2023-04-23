class ChatsController < ApplicationController
  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  def completion
    @chat = Chat.find(params[:chat_id])
    message = @chat.competion(completion_params[:content])
    render json: message
  end

  private

  def chat_params
    params.require(:chat).permit(:ai_model)
  end

  def completion_params
    params.require(:message).permit(:content)
  end
end
