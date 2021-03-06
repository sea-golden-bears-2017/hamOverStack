class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :description, null: false
      t.boolean :best_answer, default: false
      t.belongs_to :user, null: false
      t.belongs_to :question, null: false

      t.timestamps null: false
    end
  end
end
