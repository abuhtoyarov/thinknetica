require_relative '../acceptance_helper'

feature 'Viewing question and answers', %q{
  If I want to view question and his answers
  As an user
  I want to visit question's page and seen aswers list
} do 

  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }
  
  scenario 'User try to view question title' do
    
    visit question_path(question)

    expect(page).to have_content question.title
  end


  scenario 'User can see answers list' do
    answer

    visit question_path(question)
    

    expect(page).to have_content(answer.body)
  end

  
end
