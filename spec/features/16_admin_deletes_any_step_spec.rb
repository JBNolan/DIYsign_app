require "rails_helper"

  # [] As an admin
  # [] I want to delete the information of any project step

feature "admin can delete project step" do
  let (:user1) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }
  let (:project1) { FactoryGirl.create(:project, user: user1) }
  let (:project2) { FactoryGirl.create(:project, user: user2) }
  let (:step1) { FactoryGirl.create(:step, project: project1) }
  let (:step2) { FactoryGirl.create(:step, project: project1) }
  let (:step3) { FactoryGirl.create(:step, project: project2) }
  let (:step4) { FactoryGirl.create(:step, project: project2) }

  scenario "admin deletes project step successfully, for which they are also the owner" do
    user1.admin = true
    user1.save
    project1
    step1
    step2
    step1.step_description = "Testdescrpt"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit edit_project_step_path(project1, step1)
    click_link 'Delete Step'

    expect(page).to_not have_content step1.step_description
    expect(page).to have_content step2.step_description
  end

  scenario "admin deletes project step successfully, for which they are not the owner" do
    user1.admin = true
    user1.save
    project2
    step3
    step4
    step3.step_description = "Testdescrpt"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit edit_project_step_path(project2, step3)
    click_link 'Delete Step'

    expect(page).to_not have_content step3.step_description
    expect(page).to have_content step4.step_description
  end
end
