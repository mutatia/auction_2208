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
end
