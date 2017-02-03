require "rails_helper"

  # [] As an admin
  # [] I want to delete the information of any project comment

feature "admin can delete project comment" do
  let (:user1) { FactoryGirl.create(:user) }
  let (:user2) { FactoryGirl.create(:user) }
  let (:project1) { FactoryGirl.create(:project, user: user1) }
  let (:project2) { FactoryGirl.create(:project, user: user2) }
  let (:comment1) { FactoryGirl.create(:comment, user: user1, project: project1) }
  let (:comment2) { FactoryGirl.create(:comment, user: user1, project: project1) }
  let (:comment3) { FactoryGirl.create(:comment, user: user2, project: project2) }
  let (:comment4) { FactoryGirl.create(:comment, user: user2, project: project2) }

  scenario "admin deletes project comment successfully, for which they are also the owner" do
    user1.admin = true
    user1.save
    project1
    comment1
    comment2
    comment1.body = "Commentbody"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit edit_project_comment_path(project1, comment1)
    click_link 'Delete Comment'

    expect(page).to_not have_content comment1.body
    expect(page).to have_content comment2.body
  end

  scenario "admin deletes project step successfully, for which they are not the owner" do
    user1.admin = true
    user1.save
    project2
    comment3
    comment4
    comment3.body = "Commentbody"

    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user1.email
    fill_in 'user_password', with: user1.password
    click_button 'Log In'

    visit edit_project_comment_path(project2, comment3)
    click_link 'Delete Comment'

    expect(page).to_not have_content comment3.body
    expect(page).to have_content comment4.body
  end
end
