require "rails_helper"

  # [] As an admin
  # [] I want to delete the information of any project

feature "admin can delete project" do
  let (:user1) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }
  let (:project1) { FactoryGirl.create(:project, user: user1) }
  let (:project2) { FactoryGirl.create(:project, user: user2) }

  scenario "admin deletes project successfully, for which they are also the owner" do
    user1.admin = true
    user1.save
    project1
    project1.title = 'Testtitle'
    project2

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit project_path(project1)
    click_link 'Update Project'
    click_link 'Delete Project'

    expect(page).to_not have_content project1.title
    expect(page).to have_content project2.title
  end

  scenario "admin deletes project successfully, for which they are not the owner" do
    user1.admin = true
    user1.save
    project1
    project2
    project2.title = 'Testtitle'

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit project_path(project2)
    
    click_link 'Update Project'
    click_link 'Delete Project'

    expect(page).to_not have_content project2.title
    expect(page).to have_content project1.title
  end
end
