require "rails_helper"

# [] An authenticated user should be able to update their email, username, zip code, and password
# [] User receives an error if above not completed correctly
# [] If above fields are specified, user successfully updates their user information

feature 'Update user information' , %Q{ As an authenticated user I want to update my infomation to keep my account up to date } do
  scenario 'Updates user information successfully' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Update Info'
    fill_in 'Email', with: 'newemail@test.com'
    fill_in 'Username', with: 'newusername'
    fill_in 'Zip Code', with: '55555'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password Confirmation', with: 'newpassword'
    fill_in 'Current Password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
  end

  scenario 'User inputs incorrect information' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Update Info'
    fill_in 'Zip Code', with: '5555'
    fill_in 'Current Password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Zip is the wrong length (should be 5 characters)')
  end
end
