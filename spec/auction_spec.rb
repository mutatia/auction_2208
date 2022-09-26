require 'rspec'
require 'date'
require './lib/item'
require './lib/attendee'
require './lib/auction'

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
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item3.add_bid(@attendee2, 15)
      @item1.add_bid(@attendee3, 50)
      expect(@auction.potential_revenue).to eq 65
    end
  end

  describe '#bidders' do
    it 'returns an array of bidder names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item3.add_bid(@attendee2, 15)
      @item1.add_bid(@attendee3, 50)
      expect(@auction.bidders).to eq ['Megan', 'Bob', 'Mike']
    end
  end

  describe '#bidder_info' do
    it 'returns hash of attendees as keys, with values of a hash with items & budget' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item3.add_bid(@attendee2, 15)
      @item1.add_bid(@attendee3, 50)
      expected_info = {

        @attendee1 => {
          :budget => 50,
          :items => [@item1]
        },

        @attendee2 => {
          :budget => 75,
          :items => [@item1, @item3]
        },

        @attendee3 => {
          :budget => 100,
          :items => [@item1]
        }
      }
      expect(@auction.bidder_info).to eq expected_info
    end
  end

  describe '#date' do
    it 'returns a formatted date as a string' do
      @auction_old = Auction.new(Date.parse('2010-10-20'))
      @auction_future = Auction.new(Date.parse('2100-1-1'))
      expect(@auction_old.date).to eq '20/10/2010'
      expect(@auction.date).to eq '26/09/2022'
      expect(@auction_future.date).to eq '01/01/2100'
    end
  end

  describe '#close_auction' do
    it 'prevents further bidding on all items & returns hash of items sold' do
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee2, 30)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
      @item5.add_bid(@attendee1, 35)

      expected_close = {
        @item1 => @attendee2,
        @item2 => 'Not Sold',
        @item3 => @attendee2,
        @item4 => @attendee3,
        @item5 => @attendee1
      }

      expect(@auction.close_auction).to eq expected_close
    end
  end
end
