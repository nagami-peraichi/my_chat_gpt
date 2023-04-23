class Message < ApplicationRecord
  belongs_to :chat

  validates :role, presence: true
  validates :content, presence: true

  def self.to_parameters
    all.map(&:to_parameter)
  end

  def to_parameter
    {
      "role": role,
      "content": content,
    }
  end
end
