class Chat < ApplicationRecord
  has_many :messages, -> { order(:id) }, dependent: :destroy

  validates :ai_model, presence: true

  after_create :create_system_messages

  def ai_model_name
    AiModel.find(ai_model).name
  end

  def create_system_messages
    messages.create!(role: "system", content: "あなたは有能なアシスタントです。")
  end

  def competion(content)
    messages.create!(role: "user", content: content)
    response = client.chat(
      parameters: {
        model: ai_model,
        messages: messages.to_parameters,
      }
    )
    logger.info("Chat Completion Response: " + response.to_s)
    message = messages.create!(response.dig("choices", 0, "message"))
    message
  end

  private

  def client
    OpenAI::Client.new
  end
end
