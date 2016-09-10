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
    query
  end
end
