module ControllerHelper
  def login(user = nil)
    user ||= create(:user)
    request.headers["Authorization"] = JsonWebToken.encode(user_id: user.id)
    user
  end
end
