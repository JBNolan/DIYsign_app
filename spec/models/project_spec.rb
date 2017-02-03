require 'rails_helper'

RSpec.describe Project, type: :model do

  it { should have_valid(:title).when('Title Test', 'Title') }
  it { should_not have_valid(:title).when(nil, '') }

  it { should have_valid(:description).when('This is a test description', 'Another') }
  it { should_not have_valid(:description).when(nil, '') }

  it { should have_valid(:picture).when('https://lh6.ggpht.com/tPbaV7h7GVHUuWHx1B1bp5R3Kjuq8Uydj61FFjvUXH7GPL9gwvvzvdS1c1uCo88CCw=h900', 'http://www.bigdiyideas.com/wp-content/uploads/2014/07/DIY-refrigerator-magnets.jpg') }
  it { should_not have_valid(:picture).when(nil, '') }

  it { should have_valid(:supplies).when('supply', 'supply test') }
  it { should_not have_valid(:supplies).when(nil, '') }

  it { should have_valid(:category).when('category test', 'crafting') }
  it { should_not have_valid(:category).when(nil, '') }

end
