require 'rails_helper'

RSpec.describe User, type: :model do
  let(:attributes) do
    {
      email: 'test@test.com',
      password: 'test123',
      first_name: 'John',
      last_name: 'Doe'
    }
  end

  let(:missing_email) { attributes.except(:email) }
  let(:email_no_at) { attributes.merge(email: 'testtest.com') }
  let(:email_no_period) { attributes.merge(email: 'test@testcom') }
  let(:email_mixed_case) { attributes.merge(email: 'Test@test.com') }
  let(:missing_password) { attributes.except(:password) }
  let(:short_password) { attributes.merge(password: 'test1') }
  let(:missing_first_name) { attributes.except(:first_name) }
  let(:first_name_numbers) { attributes.merge(first_name: 'Jo4n') }
  let(:missing_last_name) { attributes.except(:last_name) }
  let(:last_name_numbers) { attributes.merge(first_name: 'Do3') }



  context 'email' do
    it 'should be present' do
      expect(User.new(missing_email)).to be_invalid
    end

    it 'should be a valid email address' do
      expect(User.new(email_no_at)).to be_invalid
      expect(User.new(email_no_period)).to be_invalid
    end

    it 'should be a unique email address' do
      User.create(attributes)
      expect(User.new(attributes)).to be_invalid
    end

    it 'should be lowercased' do
      user = User.create(email_mixed_case)
      expect(user.email).to eq('test@test.com')
    end
  end


  context 'password' do
    it 'should be present' do
      expect(User.new(missing_password)).to be_invalid
    end

    it 'should be at least 6 characters long' do
      expect(User.new(short_password)).to be_invalid
    end
  end


  context 'first name' do
    it 'should be present' do
      expect(User.new(missing_first_name)).to be_invalid
    end

    it 'should not have numbers' do
      expect(User.new(first_name_numbers)).to be_invalid
    end
  end

  context 'last name' do
    it 'should be present' do
      expect(User.new(missing_last_name)).to be_invalid
    end

    it 'should not have numbers' do
      expect(User.new(last_name_numbers)).to be_invalid
    end
  end
end
