require "rails_helper"

  # [] As an authenticated user
  # [] I want to update a comment to a project in which I'm the owner

feature "authenticated user can update a comment for a project that they've created" do
  scenario "authenticated user updates comment successfully" do
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

    fill_in 'Body', with: 'This is the updated body now'
    click_button 'Update Comment'

    expect(page).to have_content 'This is the updated body now'
  end

  scenario "authenticated user unable to update step because of invalid information" do
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

    fill_in 'Body', with: ''
    click_button 'Update Comment'

    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario "authenticated user unable to update comment because they are not owner of comment" do
    comment_owner = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: comment_owner)
    comment = FactoryGirl.create(:comment, user: comment_owner, project: project)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit project_path(project)

    expect(page).to_not have_link 'Update Comment'
  end
end
