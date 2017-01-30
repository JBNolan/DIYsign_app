require "rails_helper"

# [] A user must have a valid email, username, zip code, and password
# [] User receives an error if above not completed correctly
# [] If above fields are specified, I am an authenticated user

feature 'sign up' , %Q{ As an unauthenticated user I want to sign up so I can see DIY projects} do
  scenario 'specifying valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Username', with: 'test'
    fill_in 'Zip Code', with: '02865'
    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Welcome to DIYsign.  Make yourself at home.")
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password confirmation does not match confirmation' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'somethingDifferent'

    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'user signs in and signs out' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Sign Out'

    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content('Sign Out')
  end
end
