require 'rails_helper'

feature 'Create answers', %q{
  If I want to answer the question
  As an authenticate user
  I want to be able to ask answers
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  

  scenario 'Authenticated user try to add answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'Body', with: 'Testing body'

    expect { click_button "Create" }.to change(question.answers, :count).by(1)
  end

  scenario 'Non-authenticated user try to add answer' do

    visit question_path(question)

    expect(page).not_to have_selector('button', text: 'Create')
  end
  
end
