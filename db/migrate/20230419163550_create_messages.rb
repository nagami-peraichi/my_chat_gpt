class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat
      t.string :role
      t.text :content
      t.json :data
      t.timestamps
    end
  end
end
