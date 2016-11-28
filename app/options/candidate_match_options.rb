class CandidateMatchOptions < Options
  # Filters
  PENDING_FILTER = 'p'
  YES_FILTER = 'y'
  NO_FILTER = 'n'
  EXPIRED_FILTER = 'e'

  def merge_filters(query)
    return query unless @filters
    @filters.each do |filter|
      case filter
      when PENDING_FILTER
        query = query.pending
      when YES_FILTER
        query = query.yes
      when NO_FILTER
        query = query.no
      when EXPIRED_FILTER
        query = query.expired
      else
        query = query
      end
    end
    query
  end
end
