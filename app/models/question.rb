class Question < ActiveRecord::Base

	has_many :answers, dependent: :destroy
	

	validates :title,:body, presence: true
	validates :title, length: {in: 5..30}
	validates :body, length: { minimum: 10 }
end
