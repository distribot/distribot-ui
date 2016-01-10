require 'spec_helper'

describe User do
  it 'has a valid factory' do
    user = FactoryGirl.create(:user)
    expect(user).to be_valid
  end

  it 'has password' do
    user = FactoryGirl.create(:user, password: 'foobar')
    user_retrieved = User.find_by(id: user.id)
    expect(user_retrieved.password.to_s).not_to eql('foobar')
  end

  it 'supports authentication' do
    user = FactoryGirl.create(:user, password: 'foobar')
    expect(user.password == 'foobar').to be_truthy
  end

  describe 'validations' do
    it 'validates uniqueness of email' do
      first = FactoryGirl.create(:user)
      expect(FactoryGirl.create(:user, email: first.email)).not_to be_valid
    end
    it 'requires email' do
      expect(FactoryGirl.create(:user, email: nil)).not_to be_valid
    end
    it 'requires valid email' do
      expect(FactoryGirl.create(:user, email: 'invalid')).not_to be_valid
    end
  end
end
