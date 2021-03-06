require 'rails_helper'

feature 'User sign in', %q{
  If i want to ask questions
  As an user
  I must to be able sign in
} do

  given(:user) { create(:user) }
  scenario 'Registered user try to login' do
    sign_in(user)
    
    expect(page).to have_content('Signed in successfully')
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'error@europroject.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Invalid email or password')
    expect(current_path).to eq new_user_session_path
  end

end
