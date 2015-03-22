require_relative '../acceptance_helper'

feature 'Best answer', %q{
  If I want to choice best answer of my question
  As an authenticate user
  I must to click on 'Best answer' button
} do 


  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, question: question) }

  describe 'Author try' do

    before do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'to find Best answer button' do

      expect(page).to have_content('Best answer')

    end

    scenario 'to find The Best' do

      click_on 'Best answer'

      expect(page).to have_content('The Best')
      
    end

  end

  

  scenario 'Authenticated user try to find Best answer button' do

    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_content('Best answer')

  end

  scenario 'Non-uthenticated user try to find Best answer button' do

    visit question_path(question)

    expect(page).to_not have_content('Best answer')

  end




end
