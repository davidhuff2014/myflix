require 'spec_helper'

feature 'user signs in' do
  scenario 'with valid email and password' do
    alice = Fabricate(:user)
    sign_in(alice)
    expect(page).to have_content alice.full_name
  end

  scenario 'with valid different case email address' do
    alice = Fabricate(:user)
    # puts alice.email
    alice.email.upcase!
    # puts alice.email
    sign_in(alice)
    expect(page).to have_content alice.full_name
    sign_out
    alice.email.downcase!
    # puts alice.email
    sign_in(alice)
    expect(page).to have_content alice.full_name
  end

  scenario 'with deactivated user' do
    alice = Fabricate(:user, active: false)
    sign_in(alice)
    expect(page).not_to have_content(alice.full_name)
    expect(page).to have_content('Your account has been suspended, please contact customer service.')
  end
end