require "rails_helper"

  # [] As an authenticated user
  # [] I want to add a comment to a project

feature "authenticated user can add a comment to a project" do
  scenario "authenticated user adds comment successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    fill_in 'Body', with: 'This is a comment'
    click_button 'Comment'

    expect(page).to have_content 'This is a comment'
  end

  scenario "authenticated user unable to add comment because of invalid information" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    fill_in 'Body', with: ''
    click_button 'Comment'

    expect(page).to have_content 'Body can\'t be blank'
  end
end
