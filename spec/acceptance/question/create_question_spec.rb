require 'rails_helper'

feature 'Create questions', %q{
  If I want to get answers from community
  As an authenticated user
  I want to be able to ask questions
} do 
  given(:user) { create(:user) }
  scenario 'Authenticated user try create question' do
    sign_in(user)
    
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Testing title'
    fill_in 'Body', with: 'Testing body'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Non-authenticate user try create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
end
