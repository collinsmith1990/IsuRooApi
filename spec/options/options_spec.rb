require 'rails_helper'

RSpec.describe Options, :type => :options do
  it "should be initialized with a params hash" do
    options = Options.new({order: "rating", filters: ['f'], order_direction: 'reverse'})

    expect(options.order).to eq('rating')
    expect(options.order_direction).to eq('reverse')
    expect(options.filters).to eq(['f'])
  end

  it "should have constants for keys" do
    expect(Options::ORDER_KEY).to eq('order')
    expect(Options::ORDER_DIRECTION_KEY).to eq('order_direction')
    expect(Options::FILTERS_KEY).to eq('filters')
  end

  describe "merge" do
    it "should return all records" do
      candidates = create_list(:candidate, 5)
      options = Options.new

      results = options.merge(candidates)

      expect(candidates).to eq(results)
    end
  end
end

