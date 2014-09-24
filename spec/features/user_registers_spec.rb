require 'spec_helper'

feature 'User registers', { js: true, vcr: true } do
  scenario 'with valid user info and valid card' do
    visit register_path
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Full Name', with: 'John Doe'

    fill_in 'Credit Card Number', with: '4242424242424242'
    fill_in 'Security Code', with: '123'
    select '7 - July', from: 'date_month'
    select '2018', from: 'date_year'

    click_button 'Sign Up'

    expect(page).to have_content("Thank you for registering with MyFlix, please sign in now.")
  end
  scenario 'with valid user info and invalid card'
  scenario 'with valid user info and declined card'
  scenario 'with invalid user info and valid card'
  scenario 'with invalid user info and invalid card'
  scenario 'with invalid user info and declined card'
end