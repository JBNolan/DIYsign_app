require 'rails_helper'

# [] Visiting the root path should contain a list of projects.

feature "user sees a list of projects" do
  scenario "sees a list of projects" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path

    expect(page).to have_content project.title
    expect(page).to have_css("img[src*='#{project.picture}']")
  end

  scenario "authorized user is taken to show page for given project" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path

    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link project.title

    expect(page).to have_content project.title
    expect(page).to have_css("img[src*='#{project.picture}']")
    expect(page).to have_content project.description
    expect(page).to have_content project.supplies
    expect(page).to have_content project.user.username
  end

  scenario "unauthorized user is unable to see a project show page" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path

    click_link project.title

    expect(page).to have_content 'Log In'
  end
end
