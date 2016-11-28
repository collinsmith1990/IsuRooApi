class Options
  ORDER_KEY = 'order'
  FILTERS_KEY = 'filters'

  attr_accessor :order, :filters

  def initialize(options = Hash.new)
    read_options(options)
  end

  def read_options(options)
    read_order(options)
    read_filters(options)
  end

  def read_order(options)
    @order = options[ORDER_KEY.to_sym]
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
    query
  end
end
