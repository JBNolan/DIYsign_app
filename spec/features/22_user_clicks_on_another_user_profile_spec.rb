require "rails_helper"

  # [] As an authenticated user
  # [] I want to view other user profiles

feature "authenticated user can view other user profiles" do

  scenario "authenticated user views another user profile" do
    signed_in_user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)
    project1 = FactoryGirl.create(:project, user: signed_in_user)
    project1.title = 'Test Title'
    project1.save
    project2 = FactoryGirl.create(:project, user: other_user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit project_path(project2)

    click_link other_user.username

    expect(page).to have_content other_user.username
    expect(page).to have_content project2.title
    expect(page).to_not have_content project1.title
  end
end
