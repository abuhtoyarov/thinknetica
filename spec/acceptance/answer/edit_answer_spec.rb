require_relative '../acceptance_helper'

feature 'Editing answers', %q{
  If I want change answer
  As an authenticate user
  I want to be able edit answer
} do 

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question, user: author) }

  describe 'Author' do

    before do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'try to find edit button' do
 
      expect(page).to have_content 'Edit answer'

    end


    scenario 'try to edit answer', js: true do

      click_on 'Edit answer'
      within '.answers' do
        fill_in 'Answer', with: 'Updated body'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Updated body'
        expect(page).to_not have_selector 'textarea'
      end      
      
    end

  end

  

  scenario 'Authenticated user try to find edit button' do

    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_content 'Edit answer'

  end

  scenario 'Non-authenticated user try to find edit button' do


    visit question_path(question)

    expect(page).to_not have_content 'Edit answer'

  end


end
