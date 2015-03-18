require 'rails_helper'

feature 'Viewing questions', %q{
  If I want to view all questions
  As an user
  I want to visit page with all questions list
} do 

  given(:questions) { Question.all  }
  given(:question) { create(:question) }
  
  scenario 'User try to view all questions' do
    
    visit questions_path

    expect(page).to have_content 'Questions list'
  end

  scenario 'User must see questions list' do

    visit questions_path

    unless questions.empty?
      expect(page).to have_selector('a', text: question.title)
    end
  end
  
end
