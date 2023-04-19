class AiModel
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :name, :string

  class << self
    def list
      [
        new(id: 'gpt-3.5-turbo-0301', name: 'GPT-3.5'),
      ]
    end

    def find(id)
      list.find { |ai_model| ai_model.id == id }
    end
  end
end
