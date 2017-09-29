class Answer < ApplicationRecord
  validates :description, :user, :question, presence: true
  belongs_to :user
  belongs_to :question
  validate :not_own_question
  validates :question, uniqueness: {scope: :user, message: "- You've already answered this question"}

  def not_own_question
    if self.question.user == self.user
      errors.add(:question, "- Cannot answer own question")
    end
  end
end