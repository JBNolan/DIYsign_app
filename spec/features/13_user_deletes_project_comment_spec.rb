require "rails_helper"

  # [] As an authenticated user
  # [] I want to delete a comment to a project in which I'm the owner

feature "authenticated user can delete a step to a project that they've created" do
  scenario "authenticated user deletes step successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    comment = FactoryGirl.create(:comment, user: user, project: project)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    click_link 'Update Comment'
    click_link 'Delete Comment'

    expect(page).to_not have_content comment.body
  end
end
