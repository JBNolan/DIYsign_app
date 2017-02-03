require "rails_helper"

  # [] As an authenticated user
  # [] I want to click on a category link and be taken to a sub index page

feature "authenticated user can navigate to a sub index page" do
  scenario "authenticated user navigates to sub index page successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)
    project2 = FactoryGirl.create(:project, user: user)
    project2.category = 'Crafting'
    project2.title = 'Testtitle'

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Home Improvement'

    expect(page).to have_content project.title
    expect(page).to_not have_content project2.title
  end

  scenario "authenticated user navigates to sub index page successfully" do
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, user: user)

    visit root_path

    click_link 'Home Improvement'

    expect(page).to have_content 'Log In'
    expect(page).to_not have_content project.title
  end
end
