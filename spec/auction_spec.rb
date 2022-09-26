require 'rspec'
require 'item'
require 'attendee'
require 'auction'

describe Auction do
  before(:each) do
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
  end

  it 'exists and has readable attributes' do
    expect(@auction).to be_an_instance_of Auction
    expect(@auction.items).to eq []
  end

  describe '#add_item' do
    it 'adds an item to the items array' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq [@item1, @item2]
    end
  end

  describe '#item_names' do
    it 'returns an array of item names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.item_names).to eq ['Chalkware Piggy Bank', 'Bamboo Picture Frame']
    end
  end
end
