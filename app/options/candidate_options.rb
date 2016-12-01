class CandidateOptions < Options
  # Orders
  RATING_ORDER = 'rating'

  # Filters
  MALE_FILTER = 'm'
  FEMALE_FILTER = 'f'
  HAS_BIO_FILTER = 'has_bio'
  HAS_PHOTO_FILTER = 'has_photo'

  def merge_order(query)
    case @order
    when RATING_ORDER 
      query = query.rating_order
    else
      query
    end
    super(query)
  end

  def merge_filters(query)
    return query unless @filters
    @filters.each do |filter|
      case filter
      when MALE_FILTER
        query = query.male
      when FEMALE_FILTER
        query = query.female
      when HAS_BIO_FILTER
        query = query.has_bio
      when HAS_PHOTO_FILTER
        query = query.has_photo
      else
        query = query
      end
    end
    query
  end
end
