FactoryGirl.define do
  factory :project do
    title 'Project Title'
    description 'Project Description'
    project_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'paul_rules.jpg')) }
    supplies 'wood; hammer; nails'
    category 'Home Improvement'
    user
  end
end
