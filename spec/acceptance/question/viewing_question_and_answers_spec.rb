require 'rails_helper'

feature 'Viewing question and answers', %q{
  If I want to view question and his answers
  As an user
  I want to visit question's page and seen aswers list
} do 

  given(:question) { create(:question) }

  scenario 'User try to view question title' do
    
    visit question_path(question)

    expect(page).to have_content question.title
  end

  scenario 'User must see answers list' do

    visit question_path(question)

    question.answers.each do |answer|
      expect(page).to have_selector('div', text: answer.body)
    end
  end
  
end
