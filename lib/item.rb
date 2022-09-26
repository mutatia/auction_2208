class Item
  attr_reader :name, :bids
  def initialize(name)
    @name = name
    @bids = Hash.new
  end

  def add_bid(attendee, bid)
    @bids[attendee] = bid
  end

  def current_high_bid
    if @bids.length > 0
      @bids.values.max
    else
      0
    end
  end
end
