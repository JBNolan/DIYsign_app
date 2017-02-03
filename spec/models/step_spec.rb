require 'rails_helper'

RSpec.describe Step, type: :model do

  it { should have_valid(:step_description).when('Step Description Test', 'Step') }
  it { should_not have_valid(:step_description).when(nil, '') }

  it { should have_valid(:step_picture).when('https://lh6.ggpht.com/tPbaV7h7GVHUuWHx1B1bp5R3Kjuq8Uydj61FFjvUXH7GPL9gwvvzvdS1c1uCo88CCw=h900', 'http://www.bigdiyideas.com/wp-content/uploads/2014/07/DIY-refrigerator-magnets.jpg') }
  it { should_not have_valid(:step_picture).when(nil, '') }

end
