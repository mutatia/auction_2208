class Item
  attr_reader :name, :bids, :biddable
  def initialize(name)
    @name = name
    @bids = Hash.new
    @biddable = true
  end

  def add_bid(attendee, bid)
    if @biddable
      @bids[attendee] = bid
    end
  end

  def current_high_bid
    if @bids.length > 0
      @bids.values.max
    else
      0
    end
  end

  def close_bidding
    @biddable = false
  end
end
