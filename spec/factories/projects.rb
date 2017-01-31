FactoryGirl.define do
  factory :project do
    title 'Project Title'
    description 'Project Description'
    picture 'http://www.apartmentguide.com/blog/wp-content/uploads/2014/03/DIY-Bookshelf-Finished-Project.png'
    supplies 'wood; hammer; nails'
    user
  end
end
