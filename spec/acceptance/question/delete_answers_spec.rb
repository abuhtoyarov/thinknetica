require 'rails_helper'

feature 'Delete answers', %q{
  If I did't want to see my answers anymore
  As an authenticated user
  I want to delete my answers
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user try to delete answer' do

    sign_in(user)
    
    visit question_path(question)
    expect(page).to have_selector('a', text: 'Delete answer')
  end

  scenario 'Non-authenticate user try to delete answer' do

    visit question_path(question)

    expect(page).not_to have_selector('a', text: 'Delete answer')
  end
  
end
