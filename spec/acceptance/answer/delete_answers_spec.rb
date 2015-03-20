require 'rails_helper'

feature 'Delete answers', %q{
  If I did't want to see my answers anymore
  As an authenticated user
  I want to delete my answers
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user try to find delete button' do

    sign_in(user)
    answer 
    
    visit question_path(question)

    expect(page).to have_selector('a', text: 'Delete answer')
    
    
  end

  scenario 'Authenticated user try to delete answer', js: true do

    sign_in(user)
    answer

    visit question_path(question)
    
    expect { click_link "Delete answer" }.to change(question.answers, :count).by(-1) 

  end

  scenario 'Non-authenticate user try to find delete button' do
    sign_in(user)

    visit question_path(question)
    create(:answer, question: question)
    
    expect(page).not_to have_selector('a', text: 'Delete answer')
    
    
  end

  
end
