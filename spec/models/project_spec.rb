require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:each) do
    User.create({email: 'test@test.com', password: 'test123', first_name: 'John', last_name: 'Doe'})
  end

  let(:attributes) do
    {
      name: 'test@test.com',
      user_id: 1
    }
  end

  let(:missing_name) { attributes.except(:name) }
  let(:long_name) { attributes.merge(name: 'The Project with the Longest Name') }
  let(:missing_user) { attributes.except(:user_id) }


  context 'name' do
    it 'should be present' do
      expect(Project.new(missing_name)).to be_invalid
    end
    it 'should be less than 30 characters' do
      expect(Project.new(long_name)).to be_invalid
    end
  end

  it 'should belong to a User' do
    expect(Project.new(missing_user)).to be_invalid
  end

end
