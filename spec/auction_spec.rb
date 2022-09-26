require 'rspec'
require 'item'
require 'attendee'
require 'auction'

describe Auction do
  before(:each) do
    @auction = Auction.new
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
  end

  it 'exists and has readable attributes' do
    expect(@auction).to be_an_instance_of Auction
    expect(@auction.items).to eq []
  end

  describe '#add_item' do
    it 'adds an item to the items array' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      expect(@auction.items).to eq [@item1, @item2, @item3, @item4]
    end
  end

  describe '#item_names' do
    it 'returns an array of item names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      expect(@auction.item_names).to eq ['Chalkware Piggy Bank', 'Bamboo Picture Frame', 'Homemade Chocolate Chip Cookies', '2 Days Dogsitting']
    end
  end

  describe '#unpopular_items' do
    it 'returns an array of items with no bids' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee1, 23)
      @item3.add_bid(@attendee2, 15)
      expect(@auction.unpopular_items).to eq [@item2, @item4, @item5]
    end
  end

  describe '#potential_revenue' do
    it 'returns the total highest bids as an int' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @item1.add_bid(@attendee1, 23)
      @item3.add_bid(@attendee2, 15)
      @item1.add_bid(@attendee3, 50)
      expect(@auction.potential_revenue).to eq 65
    end
  end
end
