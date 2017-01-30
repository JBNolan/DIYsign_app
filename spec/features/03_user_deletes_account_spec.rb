require "rails_helper"

  # [] As an authenticated user
  # [] I want to destroy a shoe in which I'm the owner

feature "authenticated user can delete their account" do
  scenario "authenticated user deletes account successfully" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Update Info'

    click_button 'Cancel My Account'

    expect(page).to have_content 'Your account has been successfully cancelled.'
  end

  scenario "unauthenticated user unable to delete any accounts" do
    visit edit_user_registration_path

    expect(page).to have_content 'Log In'
  end
end
