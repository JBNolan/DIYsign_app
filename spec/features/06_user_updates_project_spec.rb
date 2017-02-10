require "rails_helper"

  # [] As an authenticated user
  # [] I want to update a project's information in which I'm the owner
  # [] So that I can correct errors or provide new information

feature "authenticated user can update project information" do
  scenario "authenticated user updates project successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit edit_project_path(project)

    fill_in 'Supplies', with: 'Screws; plastic'
    click_button 'Update Project'

    expect(page).to have_content "Screws plastic"
  end

  scenario "authenticated user unable to update project because of invalid data" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit edit_project_path(project)

    fill_in 'Description', with: ''
    click_button 'Update Project'

    expect(page).to have_content "Description can't be blank"
  end

  scenario 'an unauthenticated user cannot navigate to a project edit page (they will be redirected to sign in page)' do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit edit_project_path(project)

    expect(page).to have_content('Log In')
  end

  scenario 'an authenticated user that is not the owner of a project cannot navigate to a project edit page (they will be redirected to that project showpage)' do
    project_owner = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: project_owner)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit edit_project_path(project)

    expect(page).to have_content('Only project owner can update project information')
  end
end
