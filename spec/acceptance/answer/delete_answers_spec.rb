require_relative '../acceptance_helper'

feature 'Delete answers', %q{
  If I did't want to see my answers anymore
  As an authenticated user
  I want to delete my answers
} do 

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given(:answer) { create(:answer, question: question, user: author) }

  scenario 'Authenticated user try to find delete button' do

    sign_in(author)
    answer 
    
    visit question_path(question)

    expect(page).to have_selector('a', text: 'Delete answer')
    
    
  end

  scenario 'Authenticated user try to delete answer', js: true do

    sign_in(author)
    answer

    visit question_path(question)

    expect { click_link "Delete answer" }.to change(question.answers, :count).by(-1) 

  end

  scenario 'Non-author try to delete button' do
    sign_in(user)
    answer

    visit question_path(question)
    
    
    expect(page).not_to have_selector('a', text: 'Delete answer')
    
    
  end

  scenario 'Non-authenticate user try to find delete button' do
    

    visit question_path(question)
    
    
    expect(page).not_to have_selector('a', text: 'Delete answer')
    
    
  end

  
end
