require "rails_helper"

  # [] As an authenticated user
  # [] I want to add a step to a project in which I'm the owner

feature "authenticated user can add a step to a project that they've created" do
  scenario "authenticated user adds step successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    fill_in 'Description', with: 'First, we sand down the wood'
    attach_file 'Step Photo', "#{Rails.root}/spec/support/images/paul_rules.jpg"
    click_button 'Add Step'

    expect(page).to have_content 'First, we sand down the wood'
    expect(page).to have_css("img[src*='paul_rules.jpg']")
  end

  scenario "authenticated user unable to add step because of invalid information" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    visit project_path(project)

    fill_in 'Description', with: ''
    attach_file 'Step Photo', "#{Rails.root}/spec/support/images/paul_rules.jpg"
    click_button 'Add Step'

    expect(page).to have_content 'Step description can\'t be blank'
  end

  scenario "authenticated user unable to add step because they are not owner of project" do
    project_owner = FactoryGirl.create(:user)
    signed_in_user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: project_owner)

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: signed_in_user.email
    fill_in 'user_password', with: signed_in_user.password
    click_button 'Log In'

    visit project_path(project)

    expect(page).to_not have_button 'Add Step'
    expect(page).to_not have_content 'Add Another Step'
  end
end
