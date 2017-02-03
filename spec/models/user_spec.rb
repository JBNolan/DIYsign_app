require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, 'kb', '', 'emc.com') }

  it { should have_valid(:username).when('username test', 'username') }
  it { should_not have_valid(:username).when(nil, '',) }

  it { should have_valid(:zip).when('04444', '33333') }
  it { should_not have_valid(:zip).when(nil, '4444', '', 'ofef4') }

  it 'has a matching password confirmation for the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
