class Answer < ActiveRecord::Base
  belongs_to :question, dependent: :destroy

  validates :body, presence: true
  validates :body, length: {minimum: 10}
end
