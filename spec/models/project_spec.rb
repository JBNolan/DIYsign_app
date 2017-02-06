require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should have_valid(:title).when('Title Test', 'Title') }
  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:description).when('This is a test description', 'Another') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:supplies).when('supply', 'supply test') }
  it { should_not have_valid(:supplies).when(nil, '') }

  it { should have_valid(:category).when('category test', 'crafting') }
  it { should_not have_valid(:category).when(nil, '') }

end
