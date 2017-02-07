require "rails_helper"

  # [] As an authenticated user
  # [] I want to view my own profile

feature "authenticated user can view their own profile" do

  scenario "authenticated user views their profile" do
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

    click_link 'My Profile'

    expect(page).to have_content signed_in_user.username
    expect(page).to have_content project1.title
    expect(page).to_not have_content project2.title
  end
end
