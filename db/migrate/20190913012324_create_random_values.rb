class CreateRandomValues < ActiveRecord::Migration[5.2]
  def change
    create_table :random_values do |t|
      t.float :value
      t.datetime :generated_at
    end
  end
end
