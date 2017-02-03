require 'rails_helper'

# [] As an admin
# [] I want to see a list of every user

feature "Admin sees a list of users" do
  let (:user1) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }

  scenario "Admin sees link to list of users " do
    user1.admin = true
    user1.save

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit root_path

    expect(page).to have_link "List of Users"
  end

  scenario "A non admin cannot see the link to list of users" do

    user2
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user2.email
    fill_in 'user_password', with: user2.password
    click_button 'Log In'

    visit root_path

    expect(page).to_not have_link "List of Users"
  end

  scenario "Admin sees list of users " do
    user1.admin = true
    user1.save
    user2

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit root_path

    click_link 'List of Users'

    expect(page).to have_content user2.username
  end
end
