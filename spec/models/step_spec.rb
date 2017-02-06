require 'rails_helper'

RSpec.describe Step, type: :model do

  it { should have_valid(:step_description).when('Step Description Test', 'Step') }
  it { should_not have_valid(:step_description).when(nil, '') }

end
