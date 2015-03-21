require_relative '../acceptance_helper'

feature 'Create answers', %q{
  If I want to answer the question
  As an authenticate user
  I want to be able to ask answers
} do 

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  

  scenario 'Authenticated user try to add answer', js: true do
    sign_in(user)

    visit question_path(question)
    fill_in 'Answer', with: 'Testing body'
    click_on 'Create'

    
    within '.answers' do
      expect(page).to have_content('Testing body')
    end
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user try to add answer' do

    visit question_path(question)

    expect(page).not_to have_selector('button', text: 'Create')
  end
  
end
