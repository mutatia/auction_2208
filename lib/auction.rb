class Auction
  attr_reader :items
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map {|item| item.name}
  end

  def unpopular_items
    @items.reject {|item| item.bids.length != 0}
  end

  def potential_revenue
    @items.map {|item| item.current_high_bid}.sum
  end

  def bidders
    @items.map {|item| item.bids.keys.map {|attendee| attendee.name}}.flatten.uniq
  end

  def attendee_bids(attendee)
    @items.select {|item| item.bids.keys.include?(attendee)}
  end

  def bidder_info
    attendees = @items.map {|item| item.bids.keys}.flatten.uniq
    attendees.each_with_object(Hash.new) do |attendee, hash|
      hash[attendee] = {
        :budget => attendee.budget,
        :items => attendee_bids(attendee)
      }
    end
  end
end
