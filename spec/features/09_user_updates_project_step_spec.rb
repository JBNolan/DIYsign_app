require "rails_helper"

  # [] As an authenticated user
  # [] I want to update a step to a project in which I'm the owner

feature "authenticated user can update a step to a project that they've created" do
  scenario "authenticated user updates step successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    step = FactoryGirl.create(:step, project: project)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    click_link 'Update Step'

    fill_in 'Description', with: 'This is the updated step'
    click_button 'Update Step'

    expect(page).to have_content 'This is the updated step'
  end

  scenario "authenticated user unable to update step because of invalid information" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    step = FactoryGirl.create(:step, project: project)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    click_link 'Update Step'

    fill_in 'Description', with: ''
    click_button 'Update Step'

    expect(page).to have_content 'Step description can\'t be blank'
  end

  scenario "authenticated user unable to update step because they are not owner of project" do
    project_owner = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: project_owner)
    step = FactoryGirl.create(:step, project: project)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit project_path(project)

    expect(page).to_not have_link 'Update Step'
  end
end
