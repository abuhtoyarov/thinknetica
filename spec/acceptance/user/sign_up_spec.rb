require_relative '../acceptance_helper'

feature 'User sign up', %q{
  If i want to ask questions
  As an user
  I must to be able sign up
} do

  
  scenario 'User try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@email.ru'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eq root_path
  end

end
