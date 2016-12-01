class Options
  # Keys
  ORDER_KEY = 'order'
  ORDER_DIRECTION_KEY = 'order_direction'
  FILTERS_KEY = 'filters'

  # Order Direction
  REVERSE_ORDER = 'reverse'

  attr_accessor :order, :order_direction, :filters

  def initialize(options = Hash.new)
    read_options(options)
  end

  def read_options(options)
    read_order(options)
    read_order_direction(options)
    read_filters(options)
  end

  def read_order(options)
    @order = options[ORDER_KEY.to_sym]
  end

  def read_order_direction(options)
    @order_direction = options[ORDER_DIRECTION_KEY.to_sym]
  end

  def read_filters(options)
    @filters = options[FILTERS_KEY.to_sym]
  end

  def merge(query)
    query = merge_filters(query)
    query = merge_order(query)
  end

  def merge_filters(query)
    query
  end

  def merge_order(query)
    set_order_direction(query)
  end

  def set_order_direction(query)
    if @order_direction == REVERSE_ORDER
      query.reverse_order
    else
      query
    end
  end
end
