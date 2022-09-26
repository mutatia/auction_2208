require 'rspec'
require 'item'
require 'attendee'
require 'auction'

describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  it 'exists and has readable attributes' do
    expect(@item1).to be_an_instance_of Item
    expect(@item1.name).to eq 'Chalkware Piggy Bank'
  end

  describe '#bids' do
    it 'returns a hash of bids' do
      expect(@item1.bids).to eq Hash.new
    end
  end

  describe '#add_bid' do
    it 'adds a bid to the bids hash' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expected_bids = {@attendee2 => 20, @attendee1 => 22}
      expect(@item1.bids).to eq expected_bids
    end
  end

  describe '#current_high_bid' do
    it 'returns the current highest bid as an int' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.current_high_bid).to eq 22
    end
  end

  describe '#close_bidding' do
    it 'prevents new bids on an item' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item1.close_bidding
      @item1.add_bid(@attendee3, 70)
      expected_bids = {@attendee2 => 20, @attendee1 => 22}
      expect(@item1.bids).to eq expected_bids
    end
  end
end
