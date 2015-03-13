require 'rails_helper'

feature 'Delete questions', %q{
  If I did't want to see my questions anymore
  As an authenticated user
  I want to delete my questions
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user try to delete question' do

    sign_in(user)
    
    visit question_path(question)
    expect { click_on "Delete" }.to change(user.questions, :count).by(-1)
  end

  scenario 'Non-authenticate user try to delete question' do

    visit question_path(question)

    expect { click_on "Delete" }.not_to change(user.questions, :count)
  end
  
end
