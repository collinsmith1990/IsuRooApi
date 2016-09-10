require 'rails_helper'

RSpec.describe Options, :type => :options do
  it "should be initialized with a params hash" do
    options = Options.new({order: "rating"})

    expect(options.order).to eq('rating')
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

