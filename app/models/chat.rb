class Chat < ApplicationRecord
  validates :ai_model, presence: true

  def model_name
    AiModel.find(ai_model).name
  end
end
