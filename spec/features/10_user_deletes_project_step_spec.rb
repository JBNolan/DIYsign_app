require "rails_helper"

  # [] As an authenticated user
  # [] I want to delete a step to a project in which I'm the owner

feature "authenticated user can delete a step to a project that they've created" do
  scenario "authenticated user deletes step successfully" do
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
    click_link 'Delete Step'

    expect(page).to_not have_content step.step_description
  end
end
