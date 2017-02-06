FactoryGirl.define do
  factory :step do
    step_photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'paul_rules.jpg')) }
    step_description 'This is the step description'
    project
  end
end
