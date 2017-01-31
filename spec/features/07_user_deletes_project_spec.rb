require "rails_helper"

  # [] As an authenticated user
  # [] I want to delete a project in which I'm the owner

feature "authenticated user can delete a project that they've created" do
  scenario "authenticated user deletes project successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    project2 = FactoryGirl.create(:project, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    click_link 'Delete Project'

    expect(page).to have_content project2.title
  end

  scenario "unauthenticated user unable to destroy project" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    visit project_path(project)

    expect(page).to_not have_link 'Delete Project'
  end

  scenario "authenticated user unable to destroy project because they are not the owner" do
    project_owner = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: project_owner)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit project_path(project)
    expect(page).to_not have_link 'Delete Project'
  end
end
