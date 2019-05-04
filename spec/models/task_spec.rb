require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    User.create({email: 'test@test.com', password: 'test123', first_name: 'John', last_name: 'Doe'})
    Project.create({name: 'Vacation'})
  end

  let(:attributes) do
    {
      text: 'Book flights',
      completed: false
    }
  end

  let(:missing_text) { attributes.except(:text) }
  let(:long_text) { attributes.merge(text: 'This task text has gone on long enough, right?') }
  let(:missing_project) { attributes.except(:project_id) }



  context 'text' do
    it 'should be present' do
      expect(Task.new(missing_text)).to be_invalid
    end
    it 'should be less than 40 characters' do
      expect(Task.new(long_text)).to be_invalid
    end
  end

  it 'should belong to a Project' do
    expect(Task.new(missing_project)).to be_invalid
  end
end
