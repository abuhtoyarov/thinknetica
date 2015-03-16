require 'rails_helper'

feature 'Delete answers', %q{
  If I did't want to see my answers anymore
  As an authenticated user
  I want to delete my answers
} do 

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user try to find delete button' do

    sign_in user
    current_user 
    
    visit question_path(question)

    question.answers.each do |answer|
      expect(page).to have_selector('a', text: 'Delete answer')
    end
  end

  scenario 'Authenticated user try to delete answer' do

    sign_in user
    current_user

    visit question_path(question)

    question.answers.each do |answer|
      expect { click_link "Delete answer" }.to change(question.answers, :count).by(-1)
    end
  end

  scenario 'Non-authenticate user try to find delete button' do

    visit question_path(question)

    question.answers.each do |answer|
      expect(page).not_to have_selector('a', text: 'Delete answer')
    end
    
  end
  
end
