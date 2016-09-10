class CandidateOptions < Options
  # Keys
  CANDIDATE_ID_KEY = 'candidate_id'

  # Orders
  MATCH_ORDER = 'match'

  # Filters
  MALE_FILTER = 'm'
  FEMALE_FILTER = 'f'
  HAS_BIO_FILTER = 'has_bio'
  HAS_PHOTO_FILTER = 'has_photo'

  attr_accessor :candidate_id

  def read_options(options)
    super(options)
    read_candidate_id(options)
  end

  def read_candidate_id(options)
    @candidate_id = options[CANDIDATE_ID_KEY.to_sym]
  end

  def merge(query)
    query = merge_filters(query)
    query = merge_order(query)
  end

  def merge_order(query)
    case @order
    when MATCH_ORDER
      query.match_order(Candidate.find(@candidate_id))
    else
      query
    end
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
