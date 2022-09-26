require 'rspec'
require 'item'
require 'attendee'
require 'auction'

describe Attendee do
  before(:each) do
    @attendee = Attendee.new({name: 'Megan', budget: '$50'})
  end

  it 'exists and has readable attributes' do
    expect(@attendee).to be_an_instance_of Attendee
    expect(@attendee.name).to eq 'Megan'
    expect(@attendee.budget).to eq 50
  end
end
