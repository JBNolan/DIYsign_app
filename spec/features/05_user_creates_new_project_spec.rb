require "rails_helper"

# [] As an authenticated user
# [] I want to create a new project
# [] So I can share with other users

feature "authenticated user can create a new project " do
  scenario "authenticated user creates project successfully" do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log In'

    click_link 'Create New Project'
    fill_in 'Title', with: 'Project Title'
    fill_in 'Description', with: 'Project Description'
    fill_in 'Picture', with: 'http://www.apartmentguide.com/blog/wp-content/uploads/2014/03/DIY-Bookshelf-Finished-Project.png'
    fill_in 'Supplies', with: 'Wood; nails; other things'

    click_button 'Create Project'

    expect(page).to have_content 'Project Title'
    expect(page).to have_css("img[src*='http://www.apartmentguide.com/blog/wp-content/uploads/2014/03/DIY-Bookshelf-Finished-Project.png']")
    expect(page).to have_content 'Project Description'
    expect(page).to have_content 'Wood; nails; other things'
    expect(page).to have_content user.username
  end

  scenario "unauthenticated user unable to create project" do
    user = FactoryGirl.create(:user)
    visit root_path
    expect(page).to_not have_content 'Create New Project'

    visit new_project_path

    expect(page).to have_content 'Log In'
  end
end
