require "rails_helper"

  # [] As an admin
  # [] I want to delete the information of any user

feature "admin can delete a user" do

  let (:user1) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }

  scenario "admin deletes another user successfully" do
    user2
    user1.admin = true
    user1.save

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit root_path

    click_link 'List of Users'

    click_link 'Delete User'

    expect(page).to_not have_content user2.username
  end
end
