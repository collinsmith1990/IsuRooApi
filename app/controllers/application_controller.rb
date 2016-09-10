class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def self.options_klass(option_klass)
    @options_klass = option_klass
  end

  def options
    options_klass = self.class.instance_variable_get(:@options_klass)
    options_klass.new(params)
  end

  def parse_boolean(value)
    ActiveRecord::Type::Boolean.new.deserialize(value)
  end
end
