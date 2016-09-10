module ResponseHelper
  def response_body
    eval(response.body)
  end
end
