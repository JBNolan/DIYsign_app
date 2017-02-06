require 'rails_helper'

# [] As a user
# [] I want to search for projects
# [] So I can find the exact one I want

feature "User searches for a project" do
  scenario "vistor searches for a specific model" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    fill_in 'Find A Project', :with => 'Project Title'
    click_button 'Search'

    expect(page).to have_content "Project Title"
  end

  scenario "User searches for a project that does not exist" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'


    fill_in 'Find A Project', :with => 'Nothing'
    click_button 'Search'

    expect(page).to_not have_content "Project Title"
  end
end
