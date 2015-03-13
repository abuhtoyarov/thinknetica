require 'rails_helper'

feature 'User sign out', %q{
  If i want to exit from my account
  As an user
  I must to be able sign out
} do

  given(:user) { create(:user) }
  scenario 'User try to sign out' do
    sign_in(user)

    visit questions_path
    click_on 'Log out'
    
    expect(page).to have_content('Signed out successfully. Questions listAsk questionLog out')
    expect(current_path).to eq root_path
  end

end
